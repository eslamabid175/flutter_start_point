import 'package:flutter/material.dart';
import 'package:project_boilerplate/core/shared/utils/user_exprience/flash_helper.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<dynamic> push(
  String named, {
  arguments,
}) =>
    Navigator.of(navigatorKey.currentContext!).push(SlideRight(
      named: named,
      arguments: arguments,
    ));

Future<dynamic> replacement(
  String named, {
  arguments,
}) =>
    Navigator.of(navigatorKey.currentContext!).pushReplacement(
      SlideRight(
        named: named,
        arguments: arguments,
      ),
    );

Future<dynamic>? pushAndRemoveUntil(String child, {arguments}) =>
    Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
      SlideRight(named: child, arguments: arguments),
      (route) => false,
    );

class SlideRight extends PageRouteBuilder {
  final String named;
  final dynamic arguments;
  final NavigatorAnimation? type;

  SlideRight({required this.named, this.arguments, this.type})
      : super(
          settings: RouteSettings(arguments: arguments, name: named),
          pageBuilder: (context, animation, secondaryAnimation) {
            final builder = AppRoutes.init.appRoutes[named];
            if (builder != null) {
              return builder(context);
            } else {
              return Scaffold(
                body: Center(
                  child: Text('Route not found: $named'),
                ),
              );
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (type) {
              case NavigatorAnimation.position:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              case NavigatorAnimation.scale:
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.1, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.decelerate,
                    ),
                  ),
                  child: child,
                );
              case NavigatorAnimation.opacity:
              default:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
            }
          },
        );
}

enum NavigatorAnimation { opacity, scale, position }

enum MessageType { success, failed, warning }

void showMessage(String msg, {MessageType messageType = MessageType.failed}) {
  if (msg.isNotEmpty) {
    FlashHelper.showToast(msg, duration: 3, type: MessageTypeTost.success);
  }
}

Future<void> showCloseConfirmationDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Confirm Close'),
      content: const Text('Are you sure you want to close this dialog?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );

  if (result == true) {
    Navigator.of(context).pop();
  }
}
