// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/shared/theme/cubit/theme_cubit.dart';
// import '../../../../core/shared/theme/cubit/theme_state.dart';
// import '../../../../core/shared/theme/theme_service.dart';
// import '../../../../core/shared/theme/themed_widgets.dart';
//
// class ThemeSettingsScreen extends StatelessWidget {
//   const ThemeSettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: const ThemedAppBar(
//           title: 'Theme Settings',
//         ),
//         body: BlocBuilder<ThemeCubit, ThemeState>(
//           builder: (context, state) {
//             final themeCubit = context.read<ThemeCubit>();
//
//             return ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 /// Theme mode selection
//                 ThemedCard(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Theme Mode',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       const SizedBox(height: 16),
//                       _buildThemeModeOption(
//                         context: context,
//                         title: 'System Default',
//                         subtitle: 'Follow system theme settings',
//                         value: ThemeMode.system,
//                         groupValue: state.themeMode,
//                         onChanged: (value) =>
//                             themeCubit.updateThemeMode(value!),
//                       ),
//                       _buildThemeModeOption(
//                         context: context,
//                         title: 'Light Theme',
//                         subtitle: 'Always use light theme',
//                         value: ThemeMode.light,
//                         groupValue: state.themeMode,
//                         onChanged: (value) =>
//                             themeCubit.updateThemeMode(value!),
//                       ),
//                       _buildThemeModeOption(
//                         context: context,
//                         title: 'Dark Theme',
//                         subtitle: 'Always use dark theme',
//                         value: ThemeMode.dark,
//                         groupValue: state.themeMode,
//                         onChanged: (value) =>
//                             themeCubit.updateThemeMode(value!),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 /// Material 3 toggle
//                 ThemedCard(
//                   child: SwitchListTile(
//                     title: const Text('Material 3 Design'),
//                     subtitle: const Text('Use Material You design system'),
//                     value: state.useMaterial3,
//                     onChanged: (value) => themeCubit.toggleMaterial3(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 /// Theme preview
//                 ThemedCard(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Theme Preview',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       const SizedBox(height: 16),
//                       _buildColorPreview(context),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 /// Quick actions
//                 ThemedCard(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Quick Actions',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       const SizedBox(height: 16),
//                       ThemedButton(
//                         onPressed: () => themeCubit.toggleTheme(),
//                         text: 'Toggle Theme',
//                         icon: Icons.brightness_6,
//                       ),
//                       const SizedBox(height: 8),
//                       ThemedButton(
//                         onPressed: () {
//                           /// Show theme info bottom sheet
//                           showModalBottomSheet(
//                             context: context,
//                             builder: (context) => _buildThemeInfoSheet(context),
//                           );
//                         },
//                         text: 'Theme Information',
//                         type: ButtonType.outlined,
//                         icon: Icons.info_outline,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       );
//
//   Widget _buildThemeModeOption({
//     required BuildContext context,
//     required String title,
//     required String subtitle,
//     required ThemeMode value,
//     required ThemeMode groupValue,
//     required ValueChanged<ThemeMode?> onChanged,
//   }) =>
//       RadioListTile<ThemeMode>(
//         title: Text(title),
//         subtitle: Text(subtitle),
//         value: value,
//         groupValue: groupValue,
//         onChanged: onChanged,
//       );
//
//   Widget _buildColorPreview(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: [
//         _buildColorChip('Primary', colorScheme.primary),
//         _buildColorChip('Secondary', colorScheme.secondary),
//         _buildColorChip('Surface', colorScheme.surface),
//         _buildColorChip('Background', colorScheme.surface),
//         _buildColorChip('Error', colorScheme.error),
//       ],
//     );
//   }
//
//   Widget _buildColorChip(String label, Color color) => Chip(
//         label: Text(
//           label,
//           style: TextStyle(
//             color: ThemeService.getContrastColor(color),
//           ),
//         ),
//         backgroundColor: color,
//       );
//
//   Widget _buildThemeInfoSheet(BuildContext context) {
//     final theme = Theme.of(context);
//     final textTheme = theme.textTheme;
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Theme Information',
//             style: textTheme.titleLarge,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Current Brightness: ${theme.brightness.name}',
//             style: textTheme.bodyMedium,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Platform: ${Theme.of(context).platform.name}',
//             style: textTheme.bodyMedium,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Material Version: ${theme.useMaterial3 ? "3" : "2"}',
//             style: textTheme.bodyMedium,
//           ),
//           const SizedBox(height: 24),
//           SizedBox(
//             width: double.infinity,
//             child: ThemedButton(
//               onPressed: () => Navigator.pop(context),
//               text: 'Close',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
