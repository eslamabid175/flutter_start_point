import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Main theme configuration class
class AppTheme {
  /// Returns the light theme configuration
  static ThemeData lightTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: AppTextStyles.fontFamily,

        /// Color scheme configuration
        colorScheme: const ColorScheme.light(
          primary: AppColors.lightPrimary,
          primaryContainer: AppColors.lightPrimaryVariant,
          secondary: AppColors.lightSecondary,
          secondaryContainer: AppColors.lightSecondaryVariant,
          onSecondary: AppColors.lightOnSecondary,
        ),

        /// Scaffold background color
        scaffoldBackgroundColor: AppColors.lightBackground,

        /// AppBar theme configuration
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.lightSurface,
          foregroundColor: AppColors.lightOnSurface,
          iconTheme: IconThemeData(
            color: AppColors.lightOnSurface,
            size: 24,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.lightOnSurface,
            size: 24,
          ),
          titleTextStyle: TextStyle(
            color: AppColors.lightOnSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),

        /// Text theme configuration
        textTheme: AppTextStyles.getTextTheme(isDarkMode: false),

        /// ElevatedButton theme configuration
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.lightOnPrimary,
            backgroundColor: AppColors.lightPrimary,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
          ),
        ),

        /// TextButton theme configuration
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.lightPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
          ),
        ),

        /// OutlinedButton theme configuration
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.lightPrimary,
            side: const BorderSide(color: AppColors.lightPrimary),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
          ),
        ),

        /// Card theme configuration
        cardTheme: CardTheme(
          color: AppColors.lightSurface,
          elevation: 2,
          shadowColor: AppColors.lightShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(8),
        ),

        /// Input decoration theme configuration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightSurface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.lightDivider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.lightDivider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(color: AppColors.lightPrimary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.lightError),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.lightError, width: 2),
          ),
          labelStyle: const TextStyle(
            color: AppColors.lightOnSurface,
            fontSize: 16,
          ),
          hintStyle: TextStyle(
            color: AppColors.lightOnSurface.withOpacity(0.6),
            fontSize: 16,
          ),
        ),

        /// Icon theme configuration
        iconTheme: const IconThemeData(
          color: AppColors.lightOnSurface,
          size: 24,
        ),

        /// Divider theme configuration
        dividerTheme: const DividerThemeData(
          color: AppColors.lightDivider,
          thickness: 1,
          space: 1,
        ),

        /// Chip theme configuration
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.lightSurface,
          deleteIconColor: AppColors.lightOnSurface,
          disabledColor: AppColors.lightDivider,
          selectedColor: AppColors.lightPrimary,
          secondarySelectedColor: AppColors.lightSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          labelStyle: const TextStyle(
            color: AppColors.lightOnSurface,
            fontSize: 14,
          ),
          secondaryLabelStyle: const TextStyle(
            color: AppColors.lightOnPrimary,
            fontSize: 14,
          ),
          brightness: Brightness.light,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.lightDivider),
          ),
        ),

        /// BottomNavigationBar theme configuration
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.lightSurface,
          selectedItemColor: AppColors.lightPrimary,
          unselectedItemColor: AppColors.lightOnSurface,
          selectedIconTheme: IconThemeData(
            color: AppColors.lightPrimary,
            size: 28,
          ),
          unselectedIconTheme: IconThemeData(
            color: AppColors.lightOnSurface,
            size: 24,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),

        /// Dialog theme configuration
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.lightSurface,
          elevation: 24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: const TextStyle(
            color: AppColors.lightOnSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          contentTextStyle: const TextStyle(
            color: AppColors.lightOnSurface,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),

        /// SnackBar theme configuration
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.lightOnSurface,
          contentTextStyle: const TextStyle(
            color: AppColors.lightSurface,
            fontSize: 14,
          ),
          actionTextColor: AppColors.lightPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  /// Returns the dark theme configuration
  static ThemeData darkTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: AppTextStyles.fontFamily,

        /// Color scheme configuration
        colorScheme: const ColorScheme.dark(
          primary: AppColors.darkPrimary,
          primaryContainer: AppColors.darkPrimaryVariant,
          secondary: AppColors.darkSecondary,
          secondaryContainer: AppColors.darkSecondaryVariant,
          surface: AppColors.darkSurface,
        ),

        /// Scaffold background color
        scaffoldBackgroundColor: AppColors.darkBackground,

        /// AppBar theme configuration
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.darkSurface,
          foregroundColor: AppColors.darkOnSurface,
          iconTheme: IconThemeData(
            color: AppColors.darkOnSurface,
            size: 24,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.darkOnSurface,
            size: 24,
          ),
          titleTextStyle: TextStyle(
            color: AppColors.darkOnSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),

        /// Text theme configuration
        textTheme: AppTextStyles.getTextTheme(isDarkMode: true),

        /// ElevatedButton theme configuration
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.darkOnPrimary,
            backgroundColor: AppColors.darkPrimary,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
          ),
        ),

        /// TextButton theme configuration
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.darkPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
          ),
        ),

        /// OutlinedButton theme configuration
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkPrimary,
            side: const BorderSide(color: AppColors.darkPrimary),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
          ),
        ),

        /// Card theme configuration
        cardTheme: CardTheme(
          color: AppColors.darkSurface,
          elevation: 2,
          shadowColor: AppColors.darkShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(8),
        ),

        /// Input decoration theme configuration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkSurface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.darkDivider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.darkDivider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(color: AppColors.darkPrimary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.darkError),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.darkError, width: 2),
          ),
          labelStyle: const TextStyle(
            color: AppColors.darkOnSurface,
            fontSize: 16,
          ),
          hintStyle: TextStyle(
            color: AppColors.darkOnSurface.withOpacity(0.6),
            fontSize: 16,
          ),
        ),

        /// Icon theme configuration
        iconTheme: const IconThemeData(
          color: AppColors.darkOnSurface,
          size: 24,
        ),

        /// Divider theme configuration
        dividerTheme: const DividerThemeData(
          color: AppColors.darkDivider,
          thickness: 1,
          space: 1,
        ),

        /// Chip theme configuration
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.darkSurface,
          deleteIconColor: AppColors.darkOnSurface,
          disabledColor: AppColors.darkDivider,
          selectedColor: AppColors.darkPrimary,
          secondarySelectedColor: AppColors.darkSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          labelStyle: const TextStyle(
            color: AppColors.darkOnSurface,
            fontSize: 14,
          ),
          secondaryLabelStyle: const TextStyle(
            color: AppColors.darkOnPrimary,
            fontSize: 14,
          ),
          brightness: Brightness.dark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.darkDivider),
          ),
        ),

        /// BottomNavigationBar theme configuration
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkSurface,
          selectedItemColor: AppColors.darkPrimary,
          unselectedItemColor: AppColors.darkOnSurface,
          selectedIconTheme: IconThemeData(
            color: AppColors.darkPrimary,
            size: 28,
          ),
          unselectedIconTheme: IconThemeData(
            color: AppColors.darkOnSurface,
            size: 24,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),

        /// Dialog theme configuration
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.darkSurface,
          elevation: 24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: const TextStyle(
            color: AppColors.darkOnSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          contentTextStyle: const TextStyle(
            color: AppColors.darkOnSurface,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),

        /// SnackBar theme configuration
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.darkSurface,
          contentTextStyle: const TextStyle(
            color: AppColors.darkOnSurface,
            fontSize: 14,
          ),
          actionTextColor: AppColors.darkPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        /// FloatingActionButton theme configuration
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.darkOnPrimary,
          elevation: 6,
          focusElevation: 8,
          hoverElevation: 8,
          highlightElevation: 12,
          shape: CircleBorder(),
        ),

        /// Switch theme configuration
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.darkPrimary;
            }
            return AppColors.darkDivider;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.darkPrimary.withOpacity(0.5);
            }
            return AppColors.darkDivider.withOpacity(0.5);
          }),
        ),

        /// Checkbox theme configuration
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.darkPrimary;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(AppColors.darkOnPrimary),
          side: const BorderSide(color: AppColors.darkDivider, width: 2),
        ),

        /// Radio theme configuration
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.darkPrimary;
            }
            return AppColors.darkDivider;
          }),
        ),

        /// Slider theme configuration
        sliderTheme: const SliderThemeData(
          activeTrackColor: AppColors.darkPrimary,
          inactiveTrackColor: AppColors.darkDivider,
          thumbColor: AppColors.darkPrimary,
          overlayColor: AppColors.darkPrimary,
          valueIndicatorColor: AppColors.darkPrimary,
          valueIndicatorTextStyle: TextStyle(
            color: AppColors.darkOnPrimary,
          ),
        ),

        /// TabBar theme configuration
        tabBarTheme: const TabBarTheme(
          labelColor: AppColors.darkPrimary,
          unselectedLabelColor: AppColors.darkOnSurface,
          indicatorColor: AppColors.darkPrimary,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),

        /// BottomSheet theme configuration
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.darkSurface,
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),

        /// PopupMenu theme configuration
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.darkSurface,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            color: AppColors.darkOnSurface,
            fontSize: 14,
          ),
        ),

        /// ListTile theme configuration
        listTileTheme: const ListTileThemeData(
          iconColor: AppColors.darkOnSurface,
          textColor: AppColors.darkOnSurface,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          style: ListTileStyle.list,
          selectedColor: AppColors.darkPrimary,
          selectedTileColor: AppColors.darkPrimary,
        ),

        /// Tooltip theme configuration
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: const TextStyle(
            color: AppColors.darkOnSurface,
            fontSize: 12,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
      );
}
