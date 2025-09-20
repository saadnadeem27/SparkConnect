import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../utils/app_logger.dart';
import '../routes/app_routes.dart';

/// Authentication controller for managing auth state and operations
class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  // Reactive variables
  final RxBool _isLoading = false.obs;
  final RxBool _isGoogleLoading = false.obs;
  final RxBool _isAppleLoading = false.obs;
  final Rxn<UserModel> _currentUser = Rxn<UserModel>();
  final RxBool _isAuthenticated = false.obs;

  // Form controllers for login/signup
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  // Form keys
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Getters
  RxBool get isLoading => _isLoading;
  RxBool get isGoogleLoading => _isGoogleLoading;
  RxBool get isAppleLoading => _isAppleLoading;
  UserModel? get currentUser => _currentUser.value;
  bool get isAuthenticated => _isAuthenticated.value;

  @override
  void onInit() {
    super.onInit();
    _initializeAuth();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    displayNameController.dispose();
    super.onClose();
  }

  /// Initialize authentication state
  void _initializeAuth() {
    // Set initial user if authenticated
    if (_authService.isAuthenticated) {
      // TODO: Fetch user profile from database
      _isAuthenticated.value = true;
    }

    // Listen to auth state changes
    _authService.authStateChanges.listen((authState) {
      final user = authState.session?.user;
      if (user != null) {
        _isAuthenticated.value = true;
        AppLogger.auth('User authenticated: ${user.id}');
        _fetchUserProfile(user.id);
      } else {
        _isAuthenticated.value = false;
        _currentUser.value = null;
        AppLogger.auth('User signed out');
      }
    });
  }

  /// Fetch user profile from database
  Future<void> _fetchUserProfile(String userId) async {
    try {
      // TODO: Implement user profile fetching from database
      AppLogger.auth('Fetching user profile for: $userId');
    } catch (e) {
      AppLogger.error('Failed to fetch user profile: $e');
    }
  }

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword() async {
    if (!loginFormKey.currentState!.validate()) return;

    try {
      _isLoading.value = true;

      final response = await _authService.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (response != null) {
        _clearFormFields();
        Get.offAllNamed(AppRoutes.home);
        Get.snackbar(
          'Success',
          'Welcome back!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      AppLogger.error('Sign in error: $e');
      Get.snackbar(
        'Error',
        'Failed to sign in. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign up with email and password
  Future<void> signUpWithEmailAndPassword() async {
    if (!signUpFormKey.currentState!.validate()) return;

    try {
      _isLoading.value = true;

      final response = await _authService.signUpWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
        displayName: displayNameController.text.trim(),
      );

      if (response != null) {
        _clearFormFields();
        Get.offAllNamed(AppRoutes.home);
        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      AppLogger.error('Sign up error: $e');
      Get.snackbar(
        'Error',
        'Failed to create account. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign up with email and password (alternative method name)
  Future<void> signUpWithEmail(
      String email, String password, String name) async {
    try {
      _isLoading.value = true;

      final response = await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        displayName: name,
      );

      if (response != null) {
        _clearFormFields();
        Get.offAllNamed(AppRoutes.home);
        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      AppLogger.error('Sign up error: $e');
      Get.snackbar(
        'Error',
        'Failed to create account. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      _isGoogleLoading.value = true;

      final response = await _authService.signInWithGoogle();

      if (response != null) {
        Get.offAllNamed(AppRoutes.home);
        Get.snackbar(
          'Success',
          'Welcome to SparkConnect!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      AppLogger.error('Google sign in error: $e');
      Get.snackbar(
        'Error',
        'Failed to sign in with Google.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isGoogleLoading.value = false;
    }
  }

  /// Sign in with Apple
  Future<void> signInWithApple() async {
    try {
      _isAppleLoading.value = true;

      final response = await _authService.signInWithApple();

      if (response != null) {
        Get.offAllNamed(AppRoutes.home);
        Get.snackbar(
          'Success',
          'Welcome to SparkConnect!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      AppLogger.error('Apple sign in error: $e');
      Get.snackbar(
        'Error',
        'Failed to sign in with Apple.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isAppleLoading.value = false;
    }
  }

  /// Reset password
  Future<void> resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      _isLoading.value = true;

      final success =
          await _authService.resetPassword(emailController.text.trim());

      if (success) {
        Get.snackbar(
          'Success',
          'Password reset email sent!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      AppLogger.error('Password reset error: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      _isLoading.value = true;

      await _authService.signOut();
      _clearFormFields();

      Get.offAllNamed(AppRoutes.login);
      Get.snackbar(
        'Success',
        'Signed out successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      AppLogger.error('Sign out error: $e');
      Get.snackbar(
        'Error',
        'Failed to sign out',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  /// Clear form fields
  void _clearFormFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    displayNameController.clear();
  }

  /// Email validator
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Password validator
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, and number';
    }

    return null;
  }

  /// Confirm password validator
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Display name validator
  String? validateDisplayName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Display name is required';
    }

    if (value.length < 2) {
      return 'Display name must be at least 2 characters';
    }

    if (value.length > 50) {
      return 'Display name must be less than 50 characters';
    }

    return null;
  }

  /// Navigate to sign up screen
  void navigateToSignUp() {
    _clearFormFields();
    Get.toNamed(AppRoutes.signUp);
  }

  /// Navigate to login screen
  void navigateToLogin() {
    _clearFormFields();
    Get.toNamed(AppRoutes.login);
  }

  /// Navigate to forgot password screen
  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  /// Check authentication status and navigate accordingly
  void checkAuthAndNavigate() {
    if (isAuthenticated) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
