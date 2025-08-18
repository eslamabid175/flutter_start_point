import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  // Padding
  Widget padding(EdgeInsetsGeometry padding) => Padding(
    padding: padding,
    child: this,
  );

  Widget paddingAll(double value) => Padding(
    padding: EdgeInsets.all(value),
    child: this,
  );

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    ),
    child: this,
  );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  // Alignment
  Widget align(Alignment alignment) => Align(
    alignment: alignment,
    child: this,
  );

  Widget center() => Center(child: this);

  // Size
  Widget sized({double? width, double? height}) => SizedBox(
    width: width,
    height: height,
    child: this,
  );

  Widget expand({int flex = 1}) => Expanded(
    flex: flex,
    child: this,
  );

  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) => Flexible(
    flex: flex,
    fit: fit,
    child: this,
  );

  // Decoration
  Widget decorated({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BoxShape shape = BoxShape.rectangle,
  }) => Container(
    decoration: BoxDecoration(
      color: color,
      image: image,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      gradient: gradient,
      shape: shape,
    ),
    child: this,
  );

  Widget card({
    Color? color,
    double? elevation,
    ShapeBorder? shape,
    EdgeInsetsGeometry? margin,
  }) => Card(
    color: color,
    elevation: elevation,
    shape: shape,
    margin: margin,
    child: this,
  );

  // Gestures
  Widget onTap(VoidCallback onTap, {bool opaque = true}) => GestureDetector(
    onTap: onTap,
    behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
    child: this,
  );

  Widget onDoubleTap(VoidCallback onDoubleTap) => GestureDetector(
    onDoubleTap: onDoubleTap,
    child: this,
  );

  Widget onLongPress(VoidCallback onLongPress) => GestureDetector(
    onLongPress: onLongPress,
    child: this,
  );

  // Visibility
  Widget visible(bool visible, {Widget? replacement}) => Visibility(
    visible: visible,
    replacement: replacement ?? const SizedBox.shrink(),
    child: this,
  );

  Widget opacity(double opacity) => Opacity(
    opacity: opacity,
    child: this,
  );

  Widget ignore(bool ignoring) => IgnorePointer(
    ignoring: ignoring,
    child: this,
  );

  Widget absorb(bool absorbing) => AbsorbPointer(
    absorbing: absorbing,
    child: this,
  );

  // Animation
  Widget animate({
    Duration duration = const Duration(milliseconds: 300),
    Duration? reverseDuration,
    Curve curve = Curves.easeInOut,
  }) => AnimatedSwitcher(
    duration: duration,
    reverseDuration: reverseDuration,
    switchInCurve: curve,
    switchOutCurve: curve,
    child: this,
  );

  Widget rotate(double angle) => Transform.rotate(
    angle: angle,
    child: this,
  );

  Widget scale(double scale) => Transform.scale(
    scale: scale,
    child: this,
  );

  Widget translate({double dx = 0, double dy = 0}) => Transform.translate(
    offset: Offset(dx, dy),
    child: this,
  );

  // Scrolling
  Widget scrollable({
    ScrollController? controller,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollPhysics? physics,
  }) => SingleChildScrollView(
    controller: controller,
    scrollDirection: scrollDirection,
    reverse: reverse,
    physics: physics,
    child: this,
  );

  // Clipping
  Widget clipRect() => ClipRect(child: this);

  Widget clipRRect(BorderRadius borderRadius) => ClipRRect(
    borderRadius: borderRadius,
    child: this,
  );

  Widget clipOval() => ClipOval(child: this);

  // Hero Animation
  Widget hero(String tag) => Hero(
    tag: tag,
    child: this,
  );

  // Safe Area
  Widget safeArea({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
  }) => SafeArea(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    child: this,
  );

  // Shimmer Effect
  Widget shimmer({
    required Color baseColor,
    required Color highlightColor,
    Duration duration = const Duration(seconds: 2),
  }) => _ShimmerWidget(
    baseColor: baseColor,
    highlightColor: highlightColor,
    duration: duration,
    child: this,
  );
}

// Shimmer Implementation
class _ShimmerWidget extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const _ShimmerWidget({
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    required this.duration,
  });

  @override
  State<_ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<_ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + _animation.value, 0.0),
              end: Alignment(1.0 + _animation.value, 0.0),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}