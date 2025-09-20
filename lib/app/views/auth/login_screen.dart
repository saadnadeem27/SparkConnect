import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_constants.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/social_login_button.dart';
import '../../widgets/custom_text_field.dart';

/// Login screen with email/password and social login options
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.largePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppConstants.largeBorderRadius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.flash_on,
                      size: 40,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  const SizedBox(height: AppConstants.largePadding),

                  // Welcome Text
                  Text(
                    'Welcome Back!',
                    style: AppTextStyles.h2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppConstants.smallPadding),

                  Text(
                    'Sign in to continue to ${AppConstants.appName}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),

                  const SizedBox(height: AppConstants.extraLargePadding),

                  // Login Form Card
                  Container(
                    padding: const EdgeInsets.all(AppConstants.largePadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppConstants.largeBorderRadius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: authController.loginFormKey,
                      child: Column(
                        children: [
                          // Email Field
                          CustomTextField(
                            controller: authController.emailController,
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: authController.validateEmail,
                          ),

                          const SizedBox(height: AppConstants.defaultPadding),

                          // Password Field
                          CustomTextField(
                            controller: authController.passwordController,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: Icons.lock_outline,
                            obscureText: true,
                            validator: authController.validatePassword,
                          ),

                          const SizedBox(height: AppConstants.smallPadding),

                          // Forgot Password Link
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed:
                                  authController.navigateToForgotPassword,
                              child: Text(
                                'Forgot Password?',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: AppConstants.largePadding),

                          // Sign In Button
                          Obx(() => GradientButton(
                                text: 'Sign In',
                                onPressed: authController.isLoading
                                    ? null
                                    : authController.signInWithEmailAndPassword,
                                isLoading: authController.isLoading,
                              )),

                          const SizedBox(height: AppConstants.largePadding),

                          // Divider
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppConstants.defaultPadding,
                                ),
                                child: Text(
                                  'OR',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),

                          const SizedBox(height: AppConstants.largePadding),

                          // Social Login Buttons
                          Row(
                            children: [
                              Expanded(
                                child: SocialLoginButton(
                                  icon: 'assets/icons/google.png',
                                  label: 'Google',
                                  onPressed: authController.signInWithGoogle,
                                ),
                              ),
                              const SizedBox(
                                  width: AppConstants.defaultPadding),
                              Expanded(
                                child: SocialLoginButton(
                                  icon: 'assets/icons/apple.png',
                                  label: 'Apple',
                                  onPressed: authController.signInWithApple,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppConstants.extraLargePadding),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      GestureDetector(
                        onTap: authController.navigateToSignUp,
                        child: Text(
                          'Sign Up',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
