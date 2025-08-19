// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/shared/theme/cubit/theme_builder.dart';
// import '../../../../core/shared/theme/cubit/theme_cubit.dart';
// import '../../../../core/shared/theme/theme_service.dart';
// import '../../../../core/shared/theme/themed_widgets.dart';
//
// class AdvancedThemeScreen extends StatefulWidget {
//   const AdvancedThemeScreen({super.key});
//
//   @override
//   State<AdvancedThemeScreen> createState() => _AdvancedThemeScreenState();
// }
//
// class _AdvancedThemeScreenState extends State<AdvancedThemeScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   bool _switchValue = false;
//   double _sliderValue = 0.5;
//   int _selectedRadio = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     /// Update system UI based on theme
//     ThemeService.updateSystemUIOverlay(context);
//
//     return Scaffold(
//       appBar: ThemedAppBar(
//         title: 'Advanced Theme Demo',
//         actions: [
//           /// Theme mode menu
//           PopupMenuButton<ThemeMode>(
//             icon: Icon(
//               ThemeService.getAdaptiveIcon(
//                 context,
//                 lightIcon: Icons.brightness_7,
//                 darkIcon: Icons.brightness_3,
//               ),
//             ),
//             onSelected: (mode) {
//               context.read<ThemeCubit>().updateThemeMode(mode);
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: ThemeMode.system,
//                 child: Text('System'),
//               ),
//               const PopupMenuItem(
//                 value: ThemeMode.light,
//                 child: Text('Light'),
//               ),
//               const PopupMenuItem(
//                 value: ThemeMode.dark,
//                 child: Text('Dark'),
//               ),
//             ],
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Components'),
//             Tab(text: 'Forms'),
//             Tab(text: 'Lists'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           /// Components Tab
//           _buildComponentsTab(),
//
//           /// Forms Tab
//           _buildFormsTab(),
//
//           /// Lists Tab
//           _buildListsTab(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildComponentsTab() => SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             /// Themed containers
//             ThemedContainer(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Themed Container',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'This is a custom themed container with automatic styling',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             /// Themed buttons
//             ThemedCard(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Themed Buttons',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 16),
//                   ThemedButton(
//                     onPressed: () {},
//                     text: 'Elevated Button',
//                     icon: Icons.send,
//                   ),
//                   const SizedBox(height: 8),
//                   ThemedButton(
//                     onPressed: () {},
//                     text: 'Outlined Button',
//                     type: ButtonType.outlined,
//                     icon: Icons.bookmark_border,
//                   ),
//                   const SizedBox(height: 8),
//                   const ThemedButton(
//                     onPressed: null,
//                     text: 'Loading Button',
//                     isLoading: true,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             /// Theme-aware content
//             ThemeBuilder(
//               builder: (context, theme, isDark) => ThemedCard(
//                 color: isDark ? Colors.blueGrey[800] : Colors.blue[50],
//                 child: Column(
//                   children: [
//                     Icon(
//                       isDark ? Icons.nightlight_round : Icons.wb_sunny,
//                       size: 48,
//                       color: isDark ? Colors.yellow : Colors.orange,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       isDark ? 'Dark Mode Active' : 'Light Mode Active',
//                       style: theme.textTheme.titleMedium,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'This content adapts to theme changes',
//                       style: theme.textTheme.bodySmall,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//
//   Widget _buildFormsTab() => SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ThemedCard(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Form Elements',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 16),
//
//                   /// Text fields
//                   ThemedTextField(
//                     controller: _nameController,
//                     labelText: 'Name',
//                     hintText: 'Enter your name',
//                     prefixIcon: const Icon(Icons.person),
//                   ),
//                   const SizedBox(height: 16),
//
//                   ThemedTextField(
//                     controller: _emailController,
//                     labelText: 'Email',
//                     hintText: 'Enter your email',
//                     keyboardType: TextInputType.emailAddress,
//                     prefixIcon: const Icon(Icons.email),
//                     errorText: _emailController.text.isNotEmpty &&
//                             !_emailController.text.contains('@')
//                         ? 'Invalid email'
//                         : null,
//                   ),
//                   const SizedBox(height: 16),
//
//                   /// Switch
//                   SwitchListTile(
//                     title: const Text('Enable notifications'),
//                     subtitle: const Text('Receive push notifications'),
//                     value: _switchValue,
//                     onChanged: (value) {
//                       setState(() {
//                         _switchValue = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 16),
//
//                   /// Slider
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Volume: ${(_sliderValue * 100).round()}%',
//                         style: Theme.of(context).textTheme.titleSmall,
//                       ),
//                       Slider(
//                         value: _sliderValue,
//                         onChanged: (value) {
//                           setState(() {
//                             _sliderValue = value;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//
//                   /// Radio buttons
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Select Option',
//                         style: Theme.of(context).textTheme.titleSmall,
//                       ),
//                       RadioListTile<int>(
//                         title: const Text('Option 1'),
//                         value: 0,
//                         groupValue: _selectedRadio,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedRadio = value!;
//                           });
//                         },
//                       ),
//                       RadioListTile<int>(
//                         title: const Text('Option 2'),
//                         value: 1,
//                         groupValue: _selectedRadio,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedRadio = value!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//
//                   /// Submit button
//                   ThemedButton(
//                     onPressed: () {
//                       /// Show themed dialog
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: const Text('Form Submitted'),
//                           content: Text(
//                             'Name: ${_nameController.text}\n'
//                             'Email: ${_emailController.text}\n'
//                             'Notifications: $_switchValue\n'
//                             'Volume: ${(_sliderValue * 100).round()}%\n'
//                             'Selected: Option ${_selectedRadio + 1}',
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('OK'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     text: 'Submit Form',
//                     icon: Icons.check,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//
//   Widget _buildListsTab() => ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           /// List tiles with theme
//           ThemedCard(
//             child: Column(
//               children: [
//                 ListTile(
//                   leading: const CircleAvatar(
//                     child: Icon(Icons.person),
//                   ),
//                   title: const Text('John Doe'),
//                   subtitle: const Text('john.doe@example.com'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.more_vert),
//                     onPressed: () {},
//                   ),
//                 ),
//                 const Divider(),
//                 ListTile(
//                   leading: const CircleAvatar(
//                     child: Icon(Icons.person),
//                   ),
//                   title: const Text('Jane Smith'),
//                   subtitle: const Text('jane.smith@example.com'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.more_vert),
//                     onPressed: () {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           /// Expansion tiles
//           ThemedCard(
//             padding: EdgeInsets.zero,
//             child: ExpansionTile(
//               title: const Text('Expandable Section'),
//               subtitle: const Text('Tap to expand'),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Text(
//                     'This is the expanded content. It can contain any widget.',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           /// Grid of themed items
//           ThemedCard(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Grid Items',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(height: 16),
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 8,
//                     mainAxisSpacing: 8,
//                   ),
//                   itemCount: 4,
//                   itemBuilder: (context, index) => ThemedContainer(
//                     padding: const EdgeInsets.all(8),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.folder,
//                           size: 48,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Item ${index + 1}',
//                           style: Theme.of(context).textTheme.titleSmall,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
// }
