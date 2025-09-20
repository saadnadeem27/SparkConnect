import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../routes/app_routes.dart';

/// Simple Authentication controller for frontend demo
class AuthController extends GetxController {
  // Reactive variables
  final RxBool _isLoading = false.obs;
  final RxBool _isGoogleLoading = false.obs;
  final RxBool _isAppleLoading = false.obs;
  final Rxn<UserModel> _currentUser = Rxn<UserModel>();
  final RxBool _isAuthenticated = true.obs; // Set to true for demo

  // Form controllers for login/signup
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  // Form keys
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Getters
  bool get isLoading => _isLoading.value;
  bool get isGoogleLoading => _isGoogleLoading.value;
  bool get isAppleLoading => _isAppleLoading.value;
  UserModel? get currentUser => _currentUser.value;
  bool get isAuthenticated => _isAuthenticated.value;

  @override
  void onInit() {
    super.onInit();
    
    // Set up a mock current user for demo
    _currentUser.value = UserModel(
      id: 'demo_user',
      email: 'demo@sparkconnect.com',
      username: 'john_doe',
      displayName: 'John Doe',
      bio: 'Demo user for SparkConnect',
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop&crop=face',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isVerified: false,
      followersCount: 1250,
      followingCount: 892,
      postsCount: 128,
    );
  }

  // Email validator
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password validator
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Navigation methods
  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  void navigateToSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  // Check auth and navigate for splash screen
  Future<void> checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (_isAuthenticated.value) {
      Get.offAllNamed(AppRoutes.initial);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  // Mock login method
  Future<void> signInWithEmailAndPassword() async {
    _isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    _isAuthenticated.value = true;
    _isLoading.value = false;
    
    Get.snackbar(
      'Success',
      'Logged in successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    
    // Navigate to main screen
    Get.offAllNamed(AppRoutes.initial);
  }

  // Mock signup method (alias for compatibility)
  Future<void> signUpWithEmail() async {
    await signUpWithEmailAndPassword();
  }

  // Mock signup method
  Future<void> signUpWithEmailAndPassword() async {
    _isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    _isAuthenticated.value = true;
    _isLoading.value = false;
    
    Get.snackbar(
      'Success',
      'Account created successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    
    // Navigate to main screen
    Get.offAllNamed(AppRoutes.initial);
  }

  // Mock Google sign in
  Future<void> signInWithGoogle() async {
    _isGoogleLoading.value = true;
    
    await Future.delayed(const Duration(seconds: 1));
    
    _isAuthenticated.value = true;
    _isGoogleLoading.value = false;
    
    Get.snackbar(
      'Success',
      'Signed in with Google!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    
    // Navigate to main screen
    Get.offAllNamed(AppRoutes.initial);
  }

  // Mock Apple sign in
  Future<void> signInWithApple() async {
    _isAppleLoading.value = true;
    
    await Future.delayed(const Duration(seconds: 1));
    
    _isAuthenticated.value = true;
    _isAppleLoading.value = false;
    
    Get.snackbar(
      'Success',
      'Signed in with Apple!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    
    // Navigate to main screen
    Get.offAllNamed(AppRoutes.initial);
  }

  // Mock reset password
  Future<void> resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    _isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    _isLoading.value = false;
    
    Get.snackbar(
      'Success',
      'Password reset email sent!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Mock logout
  Future<void> signOut() async {
    _isAuthenticated.value = false;
    _currentUser.value = null;
    
    // Clear form controllers
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    displayNameController.clear();
    
    Get.snackbar(
      'Logged Out',
      'You have been signed out',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
    
    // Navigate to login screen
    Get.offAllNamed(AppRoutes.login);
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
}