import 'package:coopah_frontend_dev_task/presentation/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._({required this.brightness});

  static ThemeData light() {
    return AppTheme._(brightness: Brightness.light)._theme;
  }

  final Brightness brightness;

  ThemeData get _theme {
    final baseTheme = ThemeData.light(useMaterial3: false);
    final colorScheme = baseTheme.colorScheme.copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      onPrimary: AppColors.surfaceColor,
      surface: AppColors.surfaceColor,
    );

    return baseTheme.copyWith(
      primaryColor: colorScheme.primary,
      indicatorColor: colorScheme.primary,
      colorScheme: colorScheme,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.surfaceColor,
          padding: AppPaddings.ax2.add(AppPaddings.hx1),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 20,
            height: 1,
            letterSpacing: 0,
            fontWeight: FontWeight.w600, // Semibold
          ),
        ),
      ),

      textTheme: baseTheme.textTheme.copyWith(
        headlineMedium: baseTheme.textTheme.headlineMedium?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: AppColors.textColor,
          fontStyle: FontStyle.italic,
        ),

        titleLarge: baseTheme.textTheme.titleLarge?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
          letterSpacing: 1,
        ),

        titleMedium: baseTheme.textTheme.titleMedium?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
        ),

        bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}

class AppSpacings {
  static const double baseSpace = 8;

  static Widget withFactor(double factor) {
    return SizedBox(height: factor * baseSpace, width: factor * baseSpace);
  }

  static const x0_5 = SizedBox(height: 0.5 * baseSpace, width: 0.5 * baseSpace);
  static const x1 = SizedBox(height: 1 * baseSpace, width: 1 * baseSpace);
  static const x1_5 = SizedBox(height: 1.5 * baseSpace, width: 1.5 * baseSpace);
  static const x2 = SizedBox(height: 2 * baseSpace, width: 2 * baseSpace);
  static const x3 = SizedBox(height: 3 * baseSpace, width: 3 * baseSpace);
  static const x4 = SizedBox(height: 4 * baseSpace, width: 4 * baseSpace);
}

class AppPaddings {
  static const double baseSpace = 8;

  static const hx0_5 = EdgeInsets.symmetric(horizontal: 0.5 * baseSpace);
  static const hx1 = EdgeInsets.symmetric(horizontal: 1 * baseSpace);
  static const hx1_5 = EdgeInsets.symmetric(horizontal: 1.5 * baseSpace);
  static const hx2 = EdgeInsets.symmetric(horizontal: 2 * baseSpace);
  static const hx3 = EdgeInsets.symmetric(horizontal: 3 * baseSpace);
  static const hx4 = EdgeInsets.symmetric(horizontal: 4 * baseSpace);

  static const vx0_5 = EdgeInsets.symmetric(vertical: 0.5 * baseSpace);
  static const vx1 = EdgeInsets.symmetric(vertical: 1 * baseSpace);
  static const vx1_5 = EdgeInsets.symmetric(vertical: 1.5 * baseSpace);
  static const vx2 = EdgeInsets.symmetric(vertical: 2 * baseSpace);
  static const vx3 = EdgeInsets.symmetric(vertical: 3 * baseSpace);
  static const vx4 = EdgeInsets.symmetric(vertical: 4 * baseSpace);

  static const ax0_5 = EdgeInsets.all(0.5 * baseSpace);
  static const ax1 = EdgeInsets.all(1 * baseSpace);
  static const ax1_5 = EdgeInsets.all(1.5 * baseSpace);
  static const ax2 = EdgeInsets.all(2 * baseSpace);
  static const ax3 = EdgeInsets.all(3 * baseSpace);
  static const ax4 = EdgeInsets.all(4 * baseSpace);
}
