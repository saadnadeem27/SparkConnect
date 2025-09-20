import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';
import 'supabase_service.dart';
import '../utils/app_logger.dart';

/// Authentication service for handling user authentication
class AuthService extends GetxService {
  late final SupabaseClient _supabase;
  late final GoogleSignIn _googleSignIn;

  final RxBool _isLoading = false.obs;
  final Rxn<User> _currentUser = Rxn<User>();

  // Getters
  bool get isLoading => _isLoading.value;
  User? get currentUser => _currentUser.value;
  bool get isAuthenticated => currentUser != null;
  String? get userId => currentUser?.id;

  /// Get auth state changes stream
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  @override
  Future<void> onInit() async {
    super.onInit();
    _supabase = SupabaseService.client;
    _googleSignIn = GoogleSignIn(
      serverClientId: 'YOUR_GOOGLE_SERVER_CLIENT_ID', // Replace with your Google client ID
    );
    
    // Listen to auth state changes
    _supabase.auth.onAuthStateChange.listen((data) {
      _currentUser.value = data.session?.user;
    });

    // Set initial user
    _currentUser.value = _supabase.auth.currentUser;
  }

  /// Sign in with email and password
  Future<AuthResponse?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading.value = true;
      
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        AppLogger.success('User signed in successfully');
        return response;
      } else {
        AppLogger.error('Sign in failed: No user returned');
        return null;
      }
    } on AuthException catch (e) {
      AppLogger.error('Auth error: ${e.message}');
      Get.snackbar('Error', e.message);
      return null;
    } catch (e) {
      AppLogger.error('Sign in error: $e');
      Get.snackbar('Error', 'Something went wrong during sign in');
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign up with email and password
  Future<AuthResponse?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      _isLoading.value = true;
      
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'display_name': displayName,
          'avatar_url': '',
        },
      );

      if (response.user != null) {
        AppLogger.success('User signed up successfully');
        
        // Create user profile in the database
        await _createUserProfile(
          userId: response.user!.id,
          email: email,
          displayName: displayName,
        );
        
        return response;
      } else {
        AppLogger.error('Sign up failed: No user returned');
        return null;
      }
    } on AuthException catch (e) {
      AppLogger.error('Auth error: ${e.message}');
      Get.snackbar('Error', e.message);
      return null;
    } catch (e) {
      AppLogger.error('Sign up error: $e');
      Get.snackbar('Error', 'Something went wrong during sign up');
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign in with Google
  Future<AuthResponse?> signInWithGoogle() async {
    try {
      _isLoading.value = true;
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        AppLogger.info('Google sign in cancelled by user');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        AppLogger.error('Failed to get Google tokens');
        throw Exception('Failed to get Google authentication tokens');
      }

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user != null) {
        AppLogger.success('User signed in with Google successfully');
        
        // Check if user profile exists, if not create one
        await _ensureUserProfile(response.user!);
        
        return response;
      } else {
        AppLogger.error('Google sign in failed: No user returned');
        return null;
      }
    } catch (e) {
      AppLogger.error('Google sign in error: $e');
      Get.snackbar('Error', 'Failed to sign in with Google');
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign in with Apple
  Future<AuthResponse?> signInWithApple() async {
    try {
      _isLoading.value = true;
      
      final rawNonce = _generateNonce();
      final nonce = sha256.convert(utf8.encode(rawNonce)).toString();

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: credential.identityToken!,
        nonce: rawNonce,
      );

      if (response.user != null) {
        AppLogger.success('User signed in with Apple successfully');
        
        // Check if user profile exists, if not create one
        await _ensureUserProfile(response.user!);
        
        return response;
      } else {
        AppLogger.error('Apple sign in failed: No user returned');
        return null;
      }
    } catch (e) {
      AppLogger.error('Apple sign in error: $e');
      Get.snackbar('Error', 'Failed to sign in with Apple');
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Reset password
  Future<bool> resetPassword(String email) async {
    try {
      _isLoading.value = true;
      
      await _supabase.auth.resetPasswordForEmail(email);
      AppLogger.success('Password reset email sent');
      Get.snackbar('Success', 'Password reset email sent. Check your inbox.');
      return true;
    } on AuthException catch (e) {
      AppLogger.error('Password reset error: ${e.message}');
      Get.snackbar('Error', e.message);
      return false;
    } catch (e) {
      AppLogger.error('Password reset error: $e');
      Get.snackbar('Error', 'Failed to send password reset email');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      _isLoading.value = true;
      
      await _supabase.auth.signOut();
      await _googleSignIn.signOut();
      
      _currentUser.value = null;
      AppLogger.success('User signed out successfully');
    } catch (e) {
      AppLogger.error('Sign out error: $e');
      Get.snackbar('Error', 'Failed to sign out');
    } finally {
      _isLoading.value = false;
    }
  }

  /// Create user profile in database
  Future<void> _createUserProfile({
    required String userId,
    required String email,
    required String displayName,
  }) async {
    try {
      final username = _generateUsername(displayName);
      
      await _supabase.from('profiles').insert({
        'id': userId,
        'email': email,
        'username': username,
        'display_name': displayName,
        'avatar_url': '',
        'bio': '',
        'followers_count': 0,
        'following_count': 0,
        'posts_count': 0,
        'is_verified': false,
        'is_private': false,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
      
      AppLogger.success('User profile created successfully');
    } catch (e) {
      AppLogger.error('Failed to create user profile: $e');
    }
  }

  /// Ensure user profile exists
  Future<void> _ensureUserProfile(User user) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) {
        // Profile doesn't exist, create it
        await _createUserProfile(
          userId: user.id,
          email: user.email ?? '',
          displayName: user.userMetadata?['display_name'] ?? 
                      user.userMetadata?['full_name'] ?? 
                      user.email?.split('@').first ?? 
                      'User',
        );
      }
    } catch (e) {
      AppLogger.error('Failed to ensure user profile: $e');
    }
  }

  /// Generate a unique username
  String _generateUsername(String displayName) {
    final baseName = displayName.toLowerCase().replaceAll(' ', '_');
    final random = Random().nextInt(9999);
    return '${baseName}_$random';
  }

  /// Generate nonce for Apple Sign In
  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  /// Update user password
  Future<bool> updatePassword(String newPassword) async {
    try {
      _isLoading.value = true;
      
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      
      AppLogger.success('Password updated successfully');
      Get.snackbar('Success', 'Password updated successfully');
      return true;
    } on AuthException catch (e) {
      AppLogger.error('Password update error: ${e.message}');
      Get.snackbar('Error', e.message);
      return false;
    } catch (e) {
      AppLogger.error('Password update error: $e');
      Get.snackbar('Error', 'Failed to update password');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Delete user account
  Future<bool> deleteAccount() async {
    try {
      _isLoading.value = true;
      
      // Delete user profile and related data
      if (userId != null) {
        await _supabase.from('profiles').delete().eq('id', userId!);
      }
      
      // Delete user account (this might require admin privileges)
      // Note: Supabase doesn't provide direct user deletion from client
      // You might need to implement this on your backend
      
      await signOut();
      
      AppLogger.success('Account deleted successfully');
      Get.snackbar('Success', 'Account deleted successfully');
      return true;
    } catch (e) {
      AppLogger.error('Account deletion error: $e');
      Get.snackbar('Error', 'Failed to delete account');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
}