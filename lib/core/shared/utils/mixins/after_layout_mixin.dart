import 'package:flutter/material.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        afterFirstLayout(context);
      }
    });
  }

  void afterFirstLayout(BuildContext context);
}

/// Usage example:
/// import 'package:flutter/material.dart';
/// import 'after_layout_mixin.dart';
/// class MyWidget extends StatefulWidget {
 /// @override
  ///_MyWidgetState createState() => _MyWidgetState();
///}
////// class _MyWidgetState extends State<MyWidget> with AfterLayoutMixin<MyWidget> {
///   @override
///   void afterFirstLayout(BuildContext context) {
///   //     // Your code here, e.g., fetching data or updating the UI
///   }
///   @override
///   Widget build(BuildContext context) {
///   return Scaffold(
///    appBar: AppBar(title: Text('After Layout Example')),