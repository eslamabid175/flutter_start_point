// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../core/di/injection_container.dart' as di;
// import '../../../../auth/presentation/bloc/auth_bloc.dart';
// import '../../viewModel/settings_bloc.dart';
//
// import '../screen/settings_screen.dart';
//
// class SettingsScreenWrapper extends StatelessWidget {
//   const SettingsScreenWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) => MultiBlocProvider(providers: [
//         BlocProvider<SettingsBloc>(create: (context) => di.sl<SettingsBloc>()),
//
//         // Add other providers if needed
//         BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>()),
//       ], child: const SettingsPage());
// }
