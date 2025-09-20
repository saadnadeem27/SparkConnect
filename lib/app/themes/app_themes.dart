import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_constants.dart';

/// App theme configuration with light and dark themes
class AppThemes {
  // Light Theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: AppTextStyles.bodyLarge.fontFamily,
        
        // Color Scheme
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          surface: AppColors.cardBackgroundColor,
          error: AppColors.errorColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.textPrimary,
          onError: Colors.white,
        ),

        // App Bar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.cardBackgroundColor,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTextStyles.appBarTitle,
          iconTheme: const IconThemeData(
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),

        // Card Theme
        cardTheme: CardTheme(
          color: AppColors.cardBackgroundColor,
          elevation: AppConstants.defaultElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          ),
          margin: const EdgeInsets.all(AppConstants.smallPadding),
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            elevation: AppConstants.defaultElevation,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.largePadding,
              vertical: AppConstants.defaultPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            ),
            textStyle: AppTextStyles.buttonMedium,
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
              vertical: AppConstants.smallPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
            ),
            textStyle: AppTextStyles.buttonMedium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),

        // Outlined Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            side: const BorderSide(color: AppColors.primaryColor),
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.largePadding,
              vertical: AppConstants.defaultPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            ),
            textStyle: AppTextStyles.buttonMedium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.cardBackgroundColor,
          contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            borderSide: const BorderSide(color: AppColors.errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
          ),
          labelStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
          errorStyle: AppTextStyles.error,
        ),

        // Bottom Navigation Bar Theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.cardBackgroundColor,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.textTertiary,
          type: BottomNavigationBarType.fixed,
          elevation: AppConstants.largeElevation,
        ),

        // Floating Action Button Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: AppConstants.largeElevation,
        ),

        // Dialog Theme
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.cardBackgroundColor,
          elevation: AppConstants.largeElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
          ),
          titleTextStyle: AppTextStyles.h5,
          contentTextStyle: AppTextStyles.bodyMedium,
        ),

        // Snack Bar Theme
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textPrimary,
          contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
          ),
          behavior: SnackBarBehavior.floating,
        ),

        // Tab Bar Theme
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.textTertiary,
          labelStyle: AppTextStyles.tabBarLabel,
          unselectedLabelStyle: AppTextStyles.tabBarLabel,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
        ),

        // Divider Theme
        dividerTheme: const DividerThemeData(
          color: AppColors.dividerColor,
          thickness: 1,
        ),

        // Icon Theme
        iconTheme: const IconThemeData(
          color: AppColors.textSecondary,
          size: 24,
        ),

        // Text Theme
        textTheme: TextTheme(
          displayLarge: AppTextStyles.h1,
          displayMedium: AppTextStyles.h2,
          displaySmall: AppTextStyles.h3,
          headlineLarge: AppTextStyles.h4,
          headlineMedium: AppTextStyles.h5,
          headlineSmall: AppTextStyles.h6,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.buttonMedium,
          labelMedium: AppTextStyles.caption,
          labelSmall: AppTextStyles.overline,
        ),
      );

  // Dark Theme
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.darkBackgroundColor,
        fontFamily: AppTextStyles.bodyLarge.fontFamily,
        
        // Color Scheme
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          surface: AppColors.darkCardBackgroundColor,
          error: AppColors.errorColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.textDarkPrimary,
          onError: Colors.white,
        ),

        // App Bar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkCardBackgroundColor,
          foregroundColor: AppColors.textDarkPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTextStyles.appBarTitleDark,
          iconTheme: const IconThemeData(
            color: AppColors.textDarkPrimary,
            size: 24,
          ),
        ),

        // Card Theme
        cardTheme: CardTheme(
          color: AppColors.darkCardBackgroundColor,
          elevation: AppConstants.defaultElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          ),
          margin: const EdgeInsets.all(AppConstants.smallPadding),
        ),

        // Similar button themes as light theme but with dark colors
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            elevation: AppConstants.defaultElevation,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.largePadding,
              vertical: AppConstants.defaultPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            ),
            textStyle: AppTextStyles.buttonMedium,
          ),
        ),

        // Input Decoration Theme for Dark
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkCardBackgroundColor,
          contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            borderSide: const BorderSide(color: AppColors.darkBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            borderSide: const BorderSide(color: AppColors.darkBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          labelStyle: AppTextStyles.bodyMediumDark.copyWith(
            color: AppColors.textDarkSecondary,
          ),
          hintStyle: AppTextStyles.bodyMediumDark.copyWith(
            color: AppColors.textDarkTertiary,
          ),
        ),

        // Bottom Navigation Bar Theme for Dark
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkCardBackgroundColor,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.textDarkTertiary,
          type: BottomNavigationBarType.fixed,
          elevation: AppConstants.largeElevation,
        ),

        // Text Theme for Dark
        textTheme: TextTheme(
          displayLarge: AppTextStyles.h1Dark,
          displayMedium: AppTextStyles.h2Dark,
          displaySmall: AppTextStyles.h3Dark,
          headlineLarge: AppTextStyles.h4Dark,
          headlineMedium: AppTextStyles.h5Dark,
          headlineSmall: AppTextStyles.h6Dark,
          bodyLarge: AppTextStyles.bodyLargeDark,
          bodyMedium: AppTextStyles.bodyMediumDark,
          bodySmall: AppTextStyles.bodySmallDark,
          labelLarge: AppTextStyles.buttonMedium,
          labelMedium: AppTextStyles.captionDark,
          labelSmall: AppTextStyles.overline,
        ),

        // Icon Theme for Dark
        iconTheme: const IconThemeData(
          color: AppColors.textDarkSecondary,
          size: 24,
        ),
      );

  // Theme Controller
  static void changeTheme() {
    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
  }

  static bool get isDarkMode => Get.isDarkMode;
}