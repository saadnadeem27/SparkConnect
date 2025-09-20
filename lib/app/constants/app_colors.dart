import 'package:flutter/material.dart';

/// Premium color palette for SparkConnect
class AppColors {
  // Primary Colors - Gradient-based
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color primary = Color(0xFF6C63FF);  // Alias for compatibility
  static const Color secondaryColor = Color(0xFF4FACFE);
  static const Color accentColor = Color(0xFF00F2FE);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryColor, accentColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );

  // Background Colors
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color backgroundLight = Color(0xFFF8F9FA);  // Alias for compatibility
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color cardBackgroundColor = Color(0xFFFFFFFF);
  static const Color darkCardBackgroundColor = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  static const Color textTertiary = Color(0xFFA0AEC0);
  static const Color textDarkPrimary = Color(0xFFE2E8F0);
  static const Color textDarkSecondary = Color(0xFFA0AEC0);
  static const Color textDarkTertiary = Color(0xFF718096);

  // Status Colors
  static const Color successColor = Color(0xFF48BB78);
  static const Color errorColor = Color(0xFFF56565);
  static const Color warningColor = Color(0xFFED8936);
  static const Color infoColor = Color(0xFF4299E1);

  // UI Element Colors
  static const Color borderColor = Color(0xFFE2E8F0);
  static const Color darkBorderColor = Color(0xFF2D3748);
  static const Color dividerColor = Color(0xFFEDF2F7);
  static const Color shadowColor = Color(0x1A000000);
  static const Color surfaceColor = Color(0xFFF7FAFC);
  
  // Like/Heart Colors
  static const Color likeColor = Color(0xFFE53E3E);
  static const Color unlikeColor = Color(0xFFA0AEC0);

  // Online Status
  static const Color onlineColor = Color(0xFF38A169);
  static const Color offlineColor = Color(0xFFA0AEC0);

  // Special Effects
  static const Color glassMorphismColor = Color(0x1AFFFFFF);
  static const Color overlayColor = Color(0x80000000);

  // Social Colors
  static const Color googleColor = Color(0xFFDB4437);
  static const Color appleColor = Color(0xFF000000);
  static const Color facebookColor = Color(0xFF4267B2);
  static const Color twitterColor = Color(0xFF1DA1F2);

  // Story Colors
  static const LinearGradient storyGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFF4ECDC4), Color(0xFF45B7D1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient viewedStoryGradient = LinearGradient(
    colors: [Color(0xFFBDBDBD), Color(0xFF9E9E9E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}