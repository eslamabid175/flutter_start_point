import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:project_boilerplate/core/shared/costants/app_color.dart';


extension ContextExtensions on BuildContext {
  // ============= THEME & COLORS =============

  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // Theme colors
  Color get primaryColor => theme.primaryColor;
  Color get primaryColorDark => theme.primaryColorDark;
  Color get primaryColorLight => theme.primaryColorLight;
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;
  Color get cardColor => theme.cardTheme.color ?? theme.cardColor;
  Color get dividerColor => theme.dividerColor;
  Color get disabledColor => theme.disabledColor;
  Color get hoverColor => theme.hoverColor;
  Color get highlightColor => theme.highlightColor;
  Color get splashColor => theme.splashColor;
  Color get focusColor => theme.focusColor;
  Color get hintColor => theme.hintColor;
  Color get shadowColor => theme.shadowColor;
  Color get canvasColor => theme.canvasColor;
  Color get backgroundColor => theme.colorScheme.background;
  Color get errorColor => theme.colorScheme.error;
  Color get onPrimaryColor => theme.colorScheme.onPrimary;
  Color get onSecondaryColor => theme.colorScheme.onSecondary;
  Color get onBackgroundColor => theme.colorScheme.onBackground;
  Color get onSurfaceColor => theme.colorScheme.onSurface;
  Color get onErrorColor => theme.colorScheme.onError;

  // Custom semantic colors
  Color get successColor => AppColors.success;
  Color get warningColor => AppColors.warning;
  Color get infoColor => AppColors.info;

  // Adaptive colors based on theme
  Color get textPrimaryColor => theme.brightness == Brightness.light
      ? AppColors.textPrimary
      : AppColors.textPrimaryDark;

  Color get textSecondaryColor => theme.brightness == Brightness.light
      ? AppColors.textSecondary
      : AppColors.textSecondaryDark;

  Color get textTertiaryColor => theme.brightness == Brightness.light
      ? AppColors.textTertiary
      : AppColors.textTertiaryDark;

  // Theme mode
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;

  // ============= TEXT STYLES =============

  // Headline styles
  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;

  // Body styles
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelSmall => textTheme.labelSmall;

  // ============= MEDIA QUERY =============

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double get statusBarHeight => mediaQuery.padding.top;
  double get bottomBarHeight => mediaQuery.padding.bottom;
  double get keyboardHeight => mediaQuery.viewInsets.bottom;
  bool get isKeyboardVisible => keyboardHeight > 0;
  double get textScaleFactor => mediaQuery.textScaleFactor;
  Brightness get platformBrightness => mediaQuery.platformBrightness;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  EdgeInsets get systemGestureInsets => mediaQuery.systemGestureInsets;

  // Safe areas
  double get safeAreaTop => mediaQuery.padding.top;
  double get safeAreaBottom => mediaQuery.padding.bottom;
  double get safeAreaLeft => mediaQuery.padding.left;
  double get safeAreaRight => mediaQuery.padding.right;

  // Screen dimensions helpers
  double widthPercent(double percent) => screenWidth * (percent / 100);
  double heightPercent(double percent) => screenHeight * (percent / 100);

  // Responsive helpers
  double responsiveWidth(double width) {
    if (screenWidth < 360) return width * 0.9;
    if (screenWidth < 414) return width;
    if (screenWidth < 768) return width * 1.1;
    return width * 1.2;
  }

  double responsiveHeight(double height) {
    if (screenHeight < 680) return height * 0.9;
    if (screenHeight < 812) return height;
    if (screenHeight < 896) return height * 1.1;
    return height * 1.2;
  }

  double responsiveFontSize(double size) {
    if (screenWidth < 360) return size * 0.9;
    if (screenWidth < 414) return size;
    if (screenWidth < 768) return size * 1.1;
    return size * 1.2;
  }

  // ============= ORIENTATION =============

  Orientation get orientation => mediaQuery.orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  // ============= DEVICE TYPE =============

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  bool get isSmallPhone => screenWidth < 360;
  bool get isMediumPhone => screenWidth >= 360 && screenWidth < 414;
  bool get isLargePhone => screenWidth >= 414 && screenWidth < 600;

  bool get isSmallTablet => screenWidth >= 600 && screenWidth < 768;
  bool get isMediumTablet => screenWidth >= 768 && screenWidth < 1024;
  bool get isLargeTablet => screenWidth >= 1024 && screenWidth < 1200;

  String get deviceType {
    if (isMobile) return 'mobile';
    if (isTablet) return 'tablet';
    return 'desktop';
  }

  // ============= PLATFORM =============

  TargetPlatform get platform => theme.platform;
  bool get isIOS => platform == TargetPlatform.iOS;
  bool get isAndroid => platform == TargetPlatform.android;
  bool get isMacOS => platform == TargetPlatform.macOS;
  bool get isWindows => platform == TargetPlatform.windows;
  bool get isLinux => platform == TargetPlatform.linux;
  bool get isFuchsia => platform == TargetPlatform.fuchsia;

  bool get isApple => isIOS || isMacOS;
  bool get isMobileOS => isIOS || isAndroid;
  bool get isDesktopOS => isMacOS || isWindows || isLinux;

  // ============= LOCALE & DIRECTIONALITY =============

  Locale get locale => Localizations.localeOf(this);
  String get languageCode => locale.languageCode;
  String? get countryCode => locale.countryCode;

  TextDirection get textDirection => Directionality.of(this);
  bool get isRTL => textDirection == TextDirection.rtl;
  bool get isLTR => textDirection == TextDirection.ltr;

  // ============= NAVIGATION =============

  NavigatorState get navigator => Navigator.of(this);
  ModalRoute? get modalRoute => ModalRoute.of(this);
  RouteSettings? get routeSettings => modalRoute?.settings;
  String? get routeName => routeSettings?.name;
  Object? get routeArguments => routeSettings?.arguments;

  // Navigation methods
  Future<T?> push<T>(Widget page, {String? name}) => navigator.push<T>(
    MaterialPageRoute(
      builder: (_) => page,
      settings: RouteSettings(name: name),
    ),
  );

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      navigator.pushNamed<T>(routeName, arguments: arguments);

  Future<T?> pushReplacement<T, TO>(Widget page, {String? name}) =>
      navigator.pushReplacement<T, TO>(
        MaterialPageRoute(
          builder: (_) => page,
          settings: RouteSettings(name: name),
        ),
      );

  Future<T?> pushReplacementNamed<T, TO>(String routeName, {Object? arguments}) =>
      navigator.pushReplacementNamed<T, TO>(routeName, arguments: arguments);

  Future<T?> pushAndRemoveUntil<T>(Widget page, {String? name}) =>
      navigator.pushAndRemoveUntil<T>(
        MaterialPageRoute(
          builder: (_) => page,
          settings: RouteSettings(name: name),
        ),
            (route) => false,
      );

  Future<T?> pushNamedAndRemoveUntil<T>(String routeName, {Object? arguments}) =>
      navigator.pushNamedAndRemoveUntil<T>(
        routeName,
            (route) => false,
        arguments: arguments,
      );

  void pop<T>([T? result]) => navigator.pop(result);

  void popUntil(String routeName) => navigator.popUntil(
    ModalRoute.withName(routeName),
  );

  void popUntilFirst() => navigator.popUntil((route) => route.isFirst);

  bool canPop() => navigator.canPop();

  void maybePop<T>([T? result]) => navigator.maybePop(result);

  // ============= SCAFFOLD & APP BAR =============

  ScaffoldState? get scaffold => Scaffold.maybeOf(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  AppBarTheme get appBarTheme => theme.appBarTheme;

  // Open drawer
  void openDrawer() => scaffold?.openDrawer();
  void openEndDrawer() => scaffold?.openEndDrawer();
  void closeDrawer() => scaffold?.closeDrawer();
  void closeEndDrawer() => scaffold?.closeEndDrawer();
  bool get hasDrawer => scaffold?.hasDrawer ?? false;
  bool get hasEndDrawer => scaffold?.hasEndDrawer ?? false;
  bool get isDrawerOpen => scaffold?.isDrawerOpen ?? false;
  bool get isEndDrawerOpen => scaffold?.isEndDrawerOpen ?? false;

  // ============= SNACKBAR =============

  void showSnackBar(
      String message, {
        Duration duration = const Duration(seconds: 3),
        SnackBarAction? action,
        Color? backgroundColor,
        Color? textColor,
        SnackBarBehavior behavior = SnackBarBehavior.floating,
        EdgeInsetsGeometry? margin,
        EdgeInsetsGeometry? padding,
        double? elevation,
        ShapeBorder? shape,
        double? width,
        DismissDirection dismissDirection = DismissDirection.down,
        Animation<double>? animation,
        VoidCallback? onVisible,
      }) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor ?? Colors.white),
        ),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
        behavior: behavior,
        margin: margin ?? (behavior == SnackBarBehavior.floating
            ? const EdgeInsets.all(16)
            : null),
        padding: padding,
        elevation: elevation,
        shape: shape ?? (behavior == SnackBarBehavior.floating
            ? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )
            : null),
        width: width,
        dismissDirection: dismissDirection,
        animation: animation,
        onVisible: onVisible,
      ),
    );
  }

  void showErrorSnackBar(String message, {Duration? duration}) => showSnackBar(
    message,
    backgroundColor: errorColor,
    textColor: Colors.white,
    duration: duration ?? const Duration(seconds: 4),
  );

  void showSuccessSnackBar(String message, {Duration? duration}) => showSnackBar(
    message,
    backgroundColor: successColor,
    textColor: Colors.white,
    duration: duration ?? const Duration(seconds: 3),
  );

  void showWarningSnackBar(String message, {Duration? duration}) => showSnackBar(
    message,
    backgroundColor: warningColor,
    textColor: Colors.white,
    duration: duration ?? const Duration(seconds: 3),
  );

  void showInfoSnackBar(String message, {Duration? duration}) => showSnackBar(
    message,
    backgroundColor: infoColor,
    textColor: Colors.white,
    duration: duration ?? const Duration(seconds: 3),
  );

  void hideSnackBar({SnackBarClosedReason reason = SnackBarClosedReason.hide}) =>
      scaffoldMessenger.hideCurrentSnackBar(reason: reason);

  void clearSnackBars() => scaffoldMessenger.clearSnackBars();

  void removeCurrentSnackBar({SnackBarClosedReason reason = SnackBarClosedReason.remove}) =>
      scaffoldMessenger.removeCurrentSnackBar(reason: reason);

  // ============= MATERIAL BANNER =============

  void showMaterialBanner({
    required Widget content,
    required List<Widget> actions,
    Widget? leading,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? leadingPadding,
    bool forceActionsBelow = false,
    Animation<double>? animation,
    VoidCallback? onVisible,
  }) {
    scaffoldMessenger.showMaterialBanner(
      MaterialBanner(
        content: content,
        actions: actions,
        leading: leading,
        backgroundColor: backgroundColor,
        padding: padding,
        leadingPadding: leadingPadding,
        forceActionsBelow: forceActionsBelow,
        animation: animation,
        onVisible: onVisible,
      ),
    );
  }

  void hideMaterialBanner() => scaffoldMessenger.hideCurrentMaterialBanner();
  void clearMaterialBanners() => scaffoldMessenger.clearMaterialBanners();
  void removeCurrentMaterialBanner() => scaffoldMessenger.removeCurrentMaterialBanner();

  // ============= DIALOGS =============

  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      traversalEdgeBehavior: traversalEdgeBehavior,
      builder: (_) => child,
    );
  }

  Future<bool> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
    Color? cancelColor,
    bool barrierDismissible = true,
    bool destructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            style: TextButton.styleFrom(
              foregroundColor: cancelColor,
            ),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            style: TextButton.styleFrom(
              foregroundColor: confirmColor ?? (destructive ? errorColor : null),
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<String?> showInputDialog({
    required String title,
    String? message,
    String? initialValue,
    String? hintText,
    String? labelText,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    int? maxLines = 1,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) async {
    final controller = TextEditingController(text: initialValue);
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<String>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message != null) ...[
                Text(message),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                maxLength: maxLength,
                maxLines: maxLines,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hintText,
                  labelText: labelText,
                ),
                validator: validator,
                autofocus: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              if (validator != null) {
                if (formKey.currentState!.validate()) {
                  context.pop(controller.text);
                }
              } else {
                context.pop(controller.text);
              }
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );

    controller.dispose();
    return result;
  }

  // Loading dialog
  void showLoadingDialog({String? message}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(message),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void hideLoadingDialog() {
    if (canPop()) {
      pop();
    }
  }

  // ============= BOTTOM SHEET =============

  Future<T?> showBottomSheet<T>({
    required Widget child,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    bool? enableDrag,
    AnimationController? transitionAnimationController,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: (_) => child,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape ?? const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      clipBehavior: clipBehavior,
      constraints: constraints,
      enableDrag: enableDrag ?? true,
      transitionAnimationController: transitionAnimationController,
    );
  }

  Future<T?> showScrollableBottomSheet<T>({
    required ScrollableWidgetBuilder builder,
    double initialChildSize = 0.5,
    double minChildSize = 0.25,
    double maxChildSize = 1.0,
    bool expand = false,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape ?? const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        expand: expand,
        builder: builder,
      ),
    );
  }

  // Fixed: Removed type parameter from PersistentBottomSheetController
  PersistentBottomSheetController showPersistentBottomSheet({
    required Widget child,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    bool? enableDrag,
    AnimationController? transitionAnimationController,
  }) {
    return scaffold!.showBottomSheet(
          (_) => child,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      enableDrag: enableDrag,
      transitionAnimationController: transitionAnimationController,
    );
  }

  // ============= DATE & TIME PICKERS =============

  // Fixed: Using Flutter's built-in showDatePicker with proper context
  Future<DateTime?> selectDate({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    TextInputType? keyboardType,
    Offset? anchorPoint,
  }) async {
    return await showDatePicker(
      context: this,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      currentDate: currentDate,
      initialEntryMode: initialEntryMode,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      fieldHintText: fieldHintText,
      fieldLabelText: fieldLabelText,
      keyboardType: keyboardType,
      anchorPoint: anchorPoint,
    );
  }

  // Fixed: Using Flutter's built-in showTimePicker with proper context
  Future<TimeOfDay?> selectTime({
    TimeOfDay? initialTime,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
    String? helpText,
    String? cancelText,
    String? confirmText,
    String? hourLabelText,
    String? minuteLabelText,
    String? errorInvalidText,
    Offset? anchorPoint,
    void Function(TimePickerEntryMode)? onEntryModeChanged,
  }) async {
    return await showTimePicker(
      context: this,
      initialTime: initialTime ?? TimeOfDay.now(),
      initialEntryMode: initialEntryMode,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      hourLabelText: hourLabelText,
      minuteLabelText: minuteLabelText,
      errorInvalidText: errorInvalidText,
      anchorPoint: anchorPoint,
      onEntryModeChanged: onEntryModeChanged,
    );
  }

  // ============= FOCUS =============

  FocusScopeNode get focusScope => FocusScope.of(this);

  void unfocus() => focusScope.unfocus();
  void requestFocus(FocusNode node) => focusScope.requestFocus(node);
  void nextFocus() => focusScope.nextFocus();
  void previousFocus() => focusScope.previousFocus();
  bool get hasFocus => focusScope.hasFocus;
  bool get hasPrimaryFocus => focusScope.hasPrimaryFocus;
  bool get canRequestFocus => focusScope.canRequestFocus;

  // ============= FORM =============

  FormState? get form => Form.maybeOf(this);

  bool? validateForm() => form?.validate();
  void saveForm() => form?.save();
  void resetForm() => form?.reset();

  // ============= SYSTEM UI =============

  void setSystemUIOverlayStyle({
    Color? statusBarColor,
    Brightness? statusBarBrightness,
    Brightness? statusBarIconBrightness,
    Color? systemNavigationBarColor,
    Brightness? systemNavigationBarIconBrightness,
    Color? systemNavigationBarDividerColor,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarBrightness: statusBarBrightness,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
        systemNavigationBarDividerColor: systemNavigationBarDividerColor,
      ),
    );
  }

  void setLightStatusBar() {
    setSystemUIOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    );
  }

  void setDarkStatusBar() {
    setSystemUIOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    );
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  // ============= UTILITIES =============

  // Get widget by key (Fixed: removed invalid method)
  T? findAncestorWidgetOfExactType<T extends Widget>() {
    return findAncestorWidgetOfExactType<T>();
  }

  // Get render object
  RenderObject? get renderObject => findRenderObject();

  // Get widget size
  Size? get widgetSize {
    final renderBox = findRenderObject() as RenderBox?;
    return renderBox?.size;
  }

  // Get widget position
  Offset? get widgetPosition {
    final renderBox = findRenderObject() as RenderBox?;
    return renderBox?.localToGlobal(Offset.zero);
  }

  // Check if widget is visible (Fixed: using proper RenderSliver methods)
  bool get isWidgetVisible {
    final renderObject = findRenderObject();
    if (renderObject == null) return false;

    // Check if render object is in viewport
    final RenderObject? viewport = renderObject.parent;
    if (viewport is RenderSliver) {
      return viewport.geometry?.visible ?? false;
    }

    // For non-sliver widgets, check if painted
    if (renderObject is RenderBox) {
      return renderObject.hasSize && renderObject.size.height > 0 && renderObject.size.width > 0;
    }

    return true;
  }

  // Copy to clipboard
  void copyToClipboard(String text, {String? message}) {
    Clipboard.setData(ClipboardData(text: text));
    showSuccessSnackBar(message ?? 'Copied to clipboard');
  }

  // Get from clipboard
  Future<String?> getFromClipboard() async {
    final data = await Clipboard.getData('text/plain');
    return data?.text;
  }
}