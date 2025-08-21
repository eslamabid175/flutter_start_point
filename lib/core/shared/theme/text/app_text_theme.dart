import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/app_colors.dart';
import '../spacing/app_dimensions.dart';

class AppTextTheme {
  AppTextTheme._();

  // Font family that supports both Arabic and English
  static String? get _fontFamily => GoogleFonts.cairo().fontFamily;

  // Alternative font families
  static String? get _arabicFontFamily => GoogleFonts.tajawal().fontFamily;
  static String? get _englishFontFamily => GoogleFonts.inter().fontFamily;

  // Get text theme based on color scheme
  static TextTheme getTextTheme(AppColorSchemeData colorScheme) {
    return TextTheme(
      // Display styles - Largest text
      displayLarge: _createTextStyle(
        fontSize: AppDimensions.fontSize56,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: AppDimensions.lineHeightTight,
        color: colorScheme.textPrimary,
      ),
      displayMedium: _createTextStyle(
        fontSize: AppDimensions.fontSize48,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: AppDimensions.lineHeightTight,
        color: colorScheme.textPrimary,
      ),
      displaySmall: _createTextStyle(
        fontSize: AppDimensions.fontSize40,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: AppDimensions.lineHeightTight,
        color: colorScheme.textPrimary,
      ),

      // Headline styles
      headlineLarge: _createTextStyle(
        fontSize: AppDimensions.headingH1,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),
      headlineMedium: _createTextStyle(
        fontSize: AppDimensions.headingH2,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),
      headlineSmall: _createTextStyle(
        fontSize: AppDimensions.headingH3,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),

      // Title styles
      titleLarge: _createTextStyle(
        fontSize: AppDimensions.fontSize22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),
      titleMedium: _createTextStyle(
        fontSize: AppDimensions.fontSizeL,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),
      titleSmall: _createTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),

      // Body styles
      bodyLarge: _createTextStyle(
        fontSize: AppDimensions.bodyLarge,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),
      bodyMedium: _createTextStyle(
        fontSize: AppDimensions.bodyMedium,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),
      bodySmall: _createTextStyle(
        fontSize: AppDimensions.bodySmall,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textSecondary,
      ),

      // Label styles
      labelLarge: _createTextStyle(
        fontSize: AppDimensions.fontSizeS,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),
      labelMedium: _createTextStyle(
        fontSize: AppDimensions.fontSizeXS,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textPrimary,
      ),
      labelSmall: _createTextStyle(
        fontSize: AppDimensions.fontSizeXXS,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: AppDimensions.lineHeightNormal,
        color: colorScheme.textSecondary,
      ),
    );
  }

  // Helper method to create text style
  static TextStyle _createTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double letterSpacing,
    required double height,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      color: color,
      decoration: TextDecoration.none,
    );
  }
}

// Custom text styles for specific use cases with context
class AppTextStyles {
  AppTextStyles._();

  // Button text style
  static TextStyle button(BuildContext context, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: AppTextTheme._fontFamily,
      fontSize: fontSize ?? AppDimensions.fontSizeS,
      fontWeight: fontWeight ?? FontWeight.w600,
      letterSpacing: 0.8,
      height: AppDimensions.lineHeightNormal,
      color: color ?? context.colors.onPrimary,
    );
  }

  // Caption text style
  static TextStyle caption(BuildContext context, {
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: AppTextTheme._fontFamily,
      fontSize: fontSize ?? AppDimensions.caption,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: AppDimensions.lineHeightNormal,
      color: color ?? context.colors.textSecondary,
    );
  }

  // Overline text style
  static TextStyle overline(BuildContext context, {
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: AppTextTheme._fontFamily,
      fontSize: fontSize ?? AppDimensions.overline,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.5,
      height: AppDimensions.lineHeightLoose,
      color: color ?? context.colors.textSecondary,
    );
  }

  // Error text style
  static TextStyle error(BuildContext context, {
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: AppTextTheme._fontFamily,
      fontSize: fontSize ?? AppDimensions.fontSizeXS,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: AppDimensions.lineHeightNormal,
      color: context.colors.error,
    );
  }

  // Link text style
  static TextStyle link(BuildContext context, {
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: AppTextTheme._fontFamily,
      fontSize: fontSize ?? AppDimensions.fontSizeM,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      height: AppDimensions.lineHeightNormal,
      color: color ?? context.colors.primary,
      decoration: TextDecoration.underline,
    );
  }

  // Success text style
  static TextStyle success(BuildContext context, {
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: AppTextTheme._fontFamily,
      fontSize: fontSize ?? AppDimensions.fontSizeS,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      height: AppDimensions.lineHeightNormal,
      color: context.colors.success,
    );
  }

  // Warning text style
  static TextStyle warning(BuildContext context, {
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: AppTextTheme._fontFamily,
      fontSize: fontSize ?? AppDimensions.fontSizeS,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      height: AppDimensions.lineHeightNormal,
      color: context.colors.warning,
    );
  }

  // Info text style
  static TextStyle info(BuildContext context, {
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: AppTextTheme._fontFamily,
      fontSize: fontSize ?? AppDimensions.fontSizeS,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      height: AppDimensions.lineHeightNormal,
      color: context.colors.info,
    );
  }

  // Code/Monospace text style
  static TextStyle code({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'monospace',
      fontSize: fontSize ?? AppDimensions.fontSizeS,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: AppDimensions.lineHeightNormal,
      color: color,
    );
  }

  // Custom responsive text style
  static TextStyle responsive(
      BuildContext context, {
        required double baseSize,
        FontWeight? fontWeight,
        Color? color,
        double? letterSpacing,
        double? height,
      }) {
    return TextStyle(
      fontFamily: AppTextTheme._fontFamily,
      fontSize: ResponsiveDimensions.fontSize(context, baseSize),
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0,
      height: height ?? AppDimensions.lineHeightNormal,
      color: color ?? context.colors.textPrimary,
    );
  }
}

// Text style modifiers extension
extension TextStyleModifiers on TextStyle {
  // Weight modifiers
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get black => copyWith(fontWeight: FontWeight.w900);

  // Style modifiers
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle get overlined => copyWith(decoration: TextDecoration.overline);

  // Line height modifiers
  TextStyle get tightHeight => copyWith(height: AppDimensions.lineHeightTight);
  TextStyle get normalHeight => copyWith(height: AppDimensions.lineHeightNormal);
  TextStyle get looseHeight => copyWith(height: AppDimensions.lineHeightLoose);
  TextStyle get xLooseHeight => copyWith(height: AppDimensions.lineHeightXLoose);

  // Letter spacing modifiers
  TextStyle get tightSpacing => copyWith(letterSpacing: -0.5);
  TextStyle get normalSpacing => copyWith(letterSpacing: 0);
  TextStyle get wideSpacing => copyWith(letterSpacing: 0.5);
  TextStyle get xWideSpacing => copyWith(letterSpacing: 1.0);
  TextStyle get xxWideSpacing => copyWith(letterSpacing: 1.5);

  // Color modifiers
  TextStyle withOpacity(double opacity) => copyWith(
    color: color?.withOpacity(opacity),
  );

  // Size modifiers
  TextStyle withSize(double size) => copyWith(fontSize: size);
  TextStyle scaled(double factor) => copyWith(
    fontSize: (fontSize ?? AppDimensions.fontSizeM) * factor,
  );

  // Shadow modifiers
  TextStyle withShadow({
    Color? color,
    double blurRadius = 4.0,
    Offset offset = const Offset(0, 2),
  }) {
    return copyWith(
      shadows: [
        Shadow(
          color: color ?? Colors.black.withOpacity(0.25),
          blurRadius: blurRadius,
          offset: offset,
        ),
      ],
    );
  }
}

// Bilingual text helper
class BilingualTextStyle {
  static TextStyle adaptive(
      BuildContext context, {
        required String text,
        TextStyle? arabicStyle,
        TextStyle? englishStyle,
        TextStyle? fallbackStyle,
      }) {
    final bool isArabic = _containsArabic(text);

    if (isArabic && arabicStyle != null) {
      return arabicStyle;
    } else if (!isArabic && englishStyle != null) {
      return englishStyle;
    }

    return fallbackStyle ??
        TextStyle(
          fontFamily: isArabic
              ? AppTextTheme._arabicFontFamily
              : AppTextTheme._englishFontFamily,
          fontSize: AppDimensions.fontSizeM,
          fontWeight: FontWeight.w400,
          height: AppDimensions.lineHeightNormal,
          color: context.colors.textPrimary,
        );
  }

  static bool _containsArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }
}

// Responsive text widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? baseSize;

  const ResponsiveText(
      this.text, {
        Key? key,
        this.style,
        this.textAlign,
        this.maxLines,
        this.overflow,
        this.baseSize,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveStyle = style?.copyWith(
      fontSize: ResponsiveDimensions.fontSize(
        context,
        style?.fontSize ?? baseSize ?? AppDimensions.fontSizeM,
      ),
    );

    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}