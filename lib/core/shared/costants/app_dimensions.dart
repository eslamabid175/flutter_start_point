import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppDimensions {
  // Private constructor to prevent instantiation
  AppDimensions._();

  // ============= SPACING =============
  // Padding & Margin
  static const double space0 = 0.0;
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space28 = 28.0;
  static const double space32 = 32.0;
  static const double space36 = 36.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space56 = 56.0;
  static const double space64 = 64.0;
  static const double space72 = 72.0;
  static const double space80 = 80.0;
  static const double space96 = 96.0;
  static const double space128 = 128.0;

  // Named Spacing
  static const double spaceXXS = space2;
  static const double spaceXS = space4;
  static const double spaceS = space8;
  static const double spaceM = space16;
  static const double spaceL = space24;
  static const double spaceXL = space32;
  static const double spaceXXL = space48;
  static const double spaceXXXL = space64;

  // ============= PADDING =============
  static const double paddingXXS = 2.0;
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 12.0;
  static const double paddingL = 16.0;
  static const double paddingXL = 20.0;
  static const double paddingXXL = 24.0;
  static const double paddingXXXL = 32.0;

  // Screen Padding
  static const double screenPaddingHorizontal = 16.0;
  static const double screenPaddingVertical = 20.0;
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenPaddingHorizontal,
    vertical: screenPaddingVertical,
  );

  // Card Padding
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardPaddingSmall = EdgeInsets.all(8.0);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(24.0);

  // List Item Padding
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );

  // ============= MARGINS =============
  static const double marginXXS = 2.0;
  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 12.0;
  static const double marginL = 16.0;
  static const double marginXL = 20.0;
  static const double marginXXL = 24.0;
  static const double marginXXXL = 32.0;

  // ============= BORDER RADIUS =============
  static const double radius0 = 0.0;
  static const double radius2 = 2.0;
  static const double radius4 = 4.0;
  static const double radius6 = 6.0;
  static const double radius8 = 8.0;
  static const double radius10 = 10.0;
  static const double radius12 = 12.0;
  static const double radius14 = 14.0;
  static const double radius16 = 16.0;
  static const double radius18 = 18.0;
  static const double radius20 = 20.0;
  static const double radius24 = 24.0;
  static const double radius28 = 28.0;
  static const double radius32 = 32.0;
  static const double radius36 = 36.0;
  static const double radius40 = 40.0;
  static const double radiusCircular = 9999.0;

  // Named Radius
  static const double radiusXS = radius4;
  static const double radiusS = radius8;
  static const double radiusM = radius12;
  static const double radiusL = radius16;
  static const double radiusXL = radius24;
  static const double radiusXXL = radius32;

  // BorderRadius Objects
  static const BorderRadius borderRadius0 = BorderRadius.zero;
  static const BorderRadius borderRadius4 = BorderRadius.all(Radius.circular(radius4));
  static const BorderRadius borderRadius8 = BorderRadius.all(Radius.circular(radius8));
  static const BorderRadius borderRadius12 = BorderRadius.all(Radius.circular(radius12));
  static const BorderRadius borderRadius16 = BorderRadius.all(Radius.circular(radius16));
  static const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(radius20));
  static const BorderRadius borderRadius24 = BorderRadius.all(Radius.circular(radius24));
  static const BorderRadius borderRadius32 = BorderRadius.all(Radius.circular(radius32));
  static const BorderRadius borderRadiusCircular = BorderRadius.all(Radius.circular(radiusCircular));

  // Top only radius
  static const BorderRadius borderRadiusTop12 = BorderRadius.vertical(
    top: Radius.circular(radius12),
  );
  static const BorderRadius borderRadiusTop16 = BorderRadius.vertical(
    top: Radius.circular(radius16),
  );
  static const BorderRadius borderRadiusTop20 = BorderRadius.vertical(
    top: Radius.circular(radius20),
  );

  // Bottom only radius
  static const BorderRadius borderRadiusBottom12 = BorderRadius.vertical(
    bottom: Radius.circular(radius12),
  );
  static const BorderRadius borderRadiusBottom16 = BorderRadius.vertical(
    bottom: Radius.circular(radius16),
  );
  static const BorderRadius borderRadiusBottom20 = BorderRadius.vertical(
    bottom: Radius.circular(radius20),
  );

  // ============= ICON SIZES =============
  static const double iconXXS = 12.0;
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 28.0;
  static const double iconXL = 32.0;
  static const double iconXXL = 40.0;
  static const double iconXXXL = 48.0;
  static const double iconHuge = 64.0;
  static const double iconGiant = 96.0;

  // ============= FONT SIZES =============
  static const double fontSize10 = 10.0;
  static const double fontSize11 = 11.0;
  static const double fontSize12 = 12.0;
  static const double fontSize13 = 13.0;
  static const double fontSize14 = 14.0;
  static const double fontSize15 = 15.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize22 = 22.0;
  static const double fontSize24 = 24.0;
  static const double fontSize26 = 26.0;
  static const double fontSize28 = 28.0;
  static const double fontSize30 = 30.0;
  static const double fontSize32 = 32.0;
  static const double fontSize34 = 34.0;
  static const double fontSize36 = 36.0;
  static const double fontSize40 = 40.0;
  static const double fontSize48 = 48.0;
  static const double fontSize56 = 56.0;
  static const double fontSize64 = 64.0;

  // Named Font Sizes
  static const double fontSizeXXS = fontSize10;
  static const double fontSizeXS = fontSize12;
  static const double fontSizeS = fontSize14;
  static const double fontSizeM = fontSize16;
  static const double fontSizeL = fontSize18;
  static const double fontSizeXL = fontSize20;
  static const double fontSizeXXL = fontSize24;
  static const double fontSizeXXXL = fontSize32;

  // Typography Sizes
  static const double headingH1 = fontSize32;
  static const double headingH2 = fontSize28;
  static const double headingH3 = fontSize24;
  static const double headingH4 = fontSize20;
  static const double headingH5 = fontSize18;
  static const double headingH6 = fontSize16;
  static const double bodyLarge = fontSize16;
  static const double bodyMedium = fontSize14;
  static const double bodySmall = fontSize12;
  static const double caption = fontSize12;
  static const double overline = fontSize10;

  // ============= LINE HEIGHTS =============
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightLoose = 1.8;
  static const double lineHeightXLoose = 2.0;

  // ============= BUTTON SIZES =============
  static const double buttonHeightXS = 32.0;
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 44.0;
  static const double buttonHeightL = 52.0;
  static const double buttonHeightXL = 60.0;

  static const double buttonMinWidth = 64.0;
  static const double buttonMaxWidth = 280.0;

  // FAB Sizes
  static const double fabSizeMini = 40.0;
  static const double fabSizeNormal = 56.0;
  static const double fabSizeLarge = 72.0;

  // ============= INPUT FIELD SIZES =============
  static const double inputHeightS = 40.0;
  static const double inputHeightM = 48.0;
  static const double inputHeightL = 56.0;

  // ============= APP BAR =============
  static const double appBarHeight = 56.0;
  static const double appBarHeightLarge = 64.0;
  static const double bottomNavBarHeight = 60.0;
  static const double tabBarHeight = 48.0;

  // ============= CARD SIZES =============
  static const double cardElevationNone = 0.0;
  static const double cardElevationXS = 1.0;
  static const double cardElevationS = 2.0;
  static const double cardElevationM = 4.0;
  static const double cardElevationL = 8.0;
  static const double cardElevationXL = 12.0;

  // ============= AVATAR SIZES =============
  static const double avatarXXS = 24.0;
  static const double avatarXS = 32.0;
  static const double avatarS = 40.0;
  static const double avatarM = 48.0;
  static const double avatarL = 56.0;
  static const double avatarXL = 64.0;
  static const double avatarXXL = 80.0;
  static const double avatarXXXL = 96.0;
  static const double avatarHuge = 128.0;

  // ============= DIVIDER =============
  static const double dividerThickness = 1.0;
  static const double dividerThicknessBold = 2.0;
  static const double dividerIndent = 16.0;

  // ============= ANIMATION DURATIONS =============
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationXSlow = Duration(milliseconds: 800);

  // ============= BREAKPOINTS =============
  static const double breakpointXS = 480.0;
  static const double breakpointS = 600.0;
  static const double breakpointM = 840.0;
  static const double breakpointL = 960.0;
  static const double breakpointXL = 1280.0;
  static const double breakpointXXL = 1440.0;
  static const double breakpointXXXL = 1920.0;

  // ============= GRID =============
  static const int gridColumns = 12;
  static const double gridGutter = 16.0;
  static const double gridMargin = 16.0;

  // ============= MAX WIDTHS =============
  static const double maxWidthPhone = 414.0;
  static const double maxWidthTablet = 768.0;
  static const double maxWidthDesktop = 1200.0;
  static const double maxWidthContent = 1140.0;
  static const double maxWidthDialog = 560.0;
  static const double maxWidthDialogSmall = 400.0;
  static const double maxWidthDialogLarge = 720.0;

  // ============= Z-INDEX =============
  static const double zIndexDropdown = 1000.0;
  static const double zIndexSticky = 1020.0;
  static const double zIndexFixed = 1030.0;
  static const double zIndexModalBackdrop = 1040.0;
  static const double zIndexModal = 1050.0;
  static const double zIndexPopover = 1060.0;
  static const double zIndexTooltip = 1070.0;

  // ============= ASPECT RATIOS =============
  static const double aspectRatio1x1 = 1.0;
  static const double aspectRatio4x3 = 4.0 / 3.0;
  static const double aspectRatio16x9 = 16.0 / 9.0;
  static const double aspectRatio21x9 = 21.0 / 9.0;
  static const double aspectRatioGolden = 1.618;

  // ============= OPACITY =============
  static const double opacityDisabled = 0.38;
  static const double opacityMedium = 0.60;
  static const double opacityHigh = 0.87;
  static const double opacityFull = 1.0;
}

// Responsive dimensions helper
class ResponsiveDimensions {
  static double width(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  static double height(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  static double diagonal(BuildContext context, double percentage) {
    final size = MediaQuery.of(context).size;
    final diagonal = math.sqrt(size.width * size.width + size.height * size.height);
    return diagonal * (percentage / 100);
  }

  static double fontSize(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimensions.breakpointS) {
      return size * 0.9;
    } else if (width < AppDimensions.breakpointM) {
      return size;
    } else {
      return size * 1.1;
    }
  }

  static EdgeInsets screenPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimensions.breakpointS) {
      return const EdgeInsets.all(16.0);
    } else if (width < AppDimensions.breakpointM) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }
}