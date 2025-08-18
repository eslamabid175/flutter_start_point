import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? image;

  const CustomErrorWidget({
    Key? key,
    required this.message,
    this.onRetry,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image != null)
              Image.asset(
                image!,
                width: 200,
                height: 200,
              )
            else
              Icon(
                Icons.error_outline,
                size: 80,
                color: Theme.of(context).colorScheme.error,
              ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

//// main.dart
// void main() {
//   // Setup Bloc Observer
//   Bloc.observer = AppBlocObserver();
//
//   // Initialize app
//   runApp(MyApp());
// }
//
// // Example Screen
// class ExampleScreen extends StatefulWidget {
//   @override
//   State<ExampleScreen> createState() => _ExampleScreenState();
// }
//
// class _ExampleScreenState extends State<ExampleScreen>
//     with AfterLayoutMixin, LoadingMixin {
//
//   @override
//   void afterFirstLayout(BuildContext context) {
//     // Called after first frame
//     Console.printSuccess('Screen loaded!');
//     _loadData();
//   }
//
//   Future<void> _loadData() async {
//     await withLoading(() async {
//       // Simulate API call
//       await 2.delay;
//
//       // Use extensions
//       final email = 'test@example.com';
//       if (email.isEmail) {
//         Console.printInfo('Valid email');
//       }
//
//       // Format date
//       final now = DateTime.now();
//       Console.printDebug('Today: ${now.formattedDate}');
//       Console.printDebug('Time ago: ${now.subtract(Duration(hours: 2)).timeAgo}');
//
//       // Use validators
//       final passwordError = Validators.password('Test123!');
//       if (passwordError == null) {
//         Console.printSuccess('Valid password');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Example'),
//       ),
//       body: isLoading
//           ? LoadingWidget(message: loadingMessage)
//           : Column(
//               children: [
//                 // Use widget extensions
//                 Text('Hello World')
//                     .paddingAll(16)
//                     .center()
//                     .onTap(() {
//                   context.showSuccessSnackBar('Tapped!');
//                 }),
//
//                 // Use context extensions
//                 if (context.isMobile)
//                   Text('Mobile Device'),
//
//                 // Use number extensions
//                 ...10.map((i) => ListTile(
//                   title: Text('Item ${i + 1}'),
//                 )),
//               ],
//             ),
//     );
//   }
// }