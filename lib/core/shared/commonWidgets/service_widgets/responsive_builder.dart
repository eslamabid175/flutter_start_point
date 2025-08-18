import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveBuilder({
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
          MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 650) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
/// usage example:
/// import 'package:flutter/material.dart';
// import 'responsive_builder.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ResponsiveBuilder(
//         mobile: _MobileView(),
//         tablet: _TabletView(),
//         desktop: _DesktopView(),
//       ),
//     );
//   }
// }
//
// class _MobileView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("📱 Mobile Layout"));
//   }
// }
//
// class _TabletView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("💻 Tablet Layout"));
//   }
// }
//
// class _DesktopView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("🖥 Desktop Layout"));
//   }
// }



///or you can use it like this:
//if (ResponsiveBuilder.isMobile(context)) {
//   print("أنت على موبايل");
// }