import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Text styles for the SparkConnect app
class AppTextStyles {
  // Base text style
  static TextStyle get _baseTextStyle => GoogleFonts.inter();

  // Headings
  static TextStyle get headingLarge => _baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: AppColors.textPrimary,
      );

  static TextStyle get h1 => _baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: AppColors.textPrimary,
      );

  // Material Design 3 style names for compatibility
  static TextStyle get headlineLarge => h1;
  static TextStyle get headlineMedium => h2;
  static TextStyle get headlineSmall => h3;

  static TextStyle get h2 => _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        height: 1.3,
        color: AppColors.textPrimary,
      );

  static TextStyle get h3 => _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.textPrimary,
      );

  static TextStyle get h4 => _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: AppColors.textPrimary,
      );

  static TextStyle get h5 => _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: AppColors.textPrimary,
      );

  static TextStyle get h6 => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: AppColors.textPrimary,
      );

  // Body Text
  static TextStyle get bodyLarge => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.5,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMedium => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.4,
        color: AppColors.textSecondary,
      );

  // Captions and Labels
  static TextStyle get caption => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.3,
        color: AppColors.textTertiary,
      );

  static TextStyle get overline => _baseTextStyle.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.6,
        letterSpacing: 1.5,
        color: AppColors.textTertiary,
      );

  // Button Text
  static TextStyle get buttonLarge => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: Colors.white,
      );

  static TextStyle get buttonMedium => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: Colors.white,
      );

  static TextStyle get buttonSmall => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: Colors.white,
      );

  // Special Text Styles
  static TextStyle get username => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: AppColors.textPrimary,
      );

  static TextStyle get hashtag => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: AppColors.primaryColor,
      );

  static TextStyle get mention => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: AppColors.primaryColor,
      );

  static TextStyle get link => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.4,
        color: AppColors.primaryColor,
        decoration: TextDecoration.underline,
      );

  static TextStyle get timestamp => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.3,
        color: AppColors.textTertiary,
      );

  static TextStyle get counter => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: AppColors.textSecondary,
      );

  static TextStyle get appBarTitle => _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: AppColors.textPrimary,
      );

  static TextStyle get tabBarLabel => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      );

  // Error text
  static TextStyle get error => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.3,
        color: AppColors.errorColor,
      );

  // Success text
  static TextStyle get success => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.3,
        color: AppColors.successColor,
      );

  // Dark theme variants
  static TextStyle get h1Dark => h1.copyWith(color: AppColors.textDarkPrimary);
  static TextStyle get h2Dark => h2.copyWith(color: AppColors.textDarkPrimary);
  static TextStyle get h3Dark => h3.copyWith(color: AppColors.textDarkPrimary);
  static TextStyle get h4Dark => h4.copyWith(color: AppColors.textDarkPrimary);
  static TextStyle get h5Dark => h5.copyWith(color: AppColors.textDarkPrimary);
  static TextStyle get h6Dark => h6.copyWith(color: AppColors.textDarkPrimary);

  static TextStyle get bodyLargeDark => bodyLarge.copyWith(color: AppColors.textDarkPrimary);
  static TextStyle get bodyMediumDark => bodyMedium.copyWith(color: AppColors.textDarkPrimary);
  static TextStyle get bodySmallDark => bodySmall.copyWith(color: AppColors.textDarkSecondary);

  static TextStyle get captionDark => caption.copyWith(color: AppColors.textDarkTertiary);
  static TextStyle get usernameDark => username.copyWith(color: AppColors.textDarkPrimary);
  static TextStyle get timestampDark => timestamp.copyWith(color: AppColors.textDarkTertiary);
  static TextStyle get counterDark => counter.copyWith(color: AppColors.textDarkSecondary);
  static TextStyle get appBarTitleDark => appBarTitle.copyWith(color: AppColors.textDarkPrimary);
}