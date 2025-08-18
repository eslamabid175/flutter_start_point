import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewModel/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('settings'.tr())),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) => ListView(
            children: [
              // Language Switcher
              ListTile(
                title: Text('language'.tr()),
                subtitle: Text(settingsState.locale.languageCode == 'en'
                    ? 'English'
                    : 'العربية'),
                trailing: const Icon(Icons.arrow_drop_down),
                onTap: () {
                  _showLanguageDialog(context, settingsState.locale);
                },
              ),
              // Dark Mode Toggle
              // SwitchListTile(
              //   title: Text('dark_mode'.tr()),
              //   value: settingsState.themeMode == ThemeMode.dark,
              //   onChanged: (value) {
              //     context.read<SettingsBloc>().add(ToggleTheme());
              //   },
              // ),
              const Divider(),
              // Logout (Consider moving to drawer or profile section)
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text('logout'.tr(),
                    style: const TextStyle(color: Colors.red)),
                onTap: () async {
                  // Show confirmation dialog
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('logout'.tr()),
                      content: Text('confirm_logout'.tr()),
                      actions: <Widget>[
                        TextButton(
                          child: Text('no'.tr()),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                          child: Text('yes'.tr()),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    ),
                  );

                  // if (confirm == true && context.mounted) {
                  //   context.read<AuthBloc>().add(LogOutEvent());
                  //   // Navigate back or to login screen after logout
                  //   pushAndRemoveUntil(NamedRoutes.i.layoutView);
                  //
                  //   //  Navigator.of(context).popUntil((route) => route.isFirst);
                  //   // Fluttertoast.showToast(msg: 'logged_out_successfully'.tr());
                  // }
                },
              ),
              // Delete Account (Consider moving to drawer or profile section)
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: Text('delete_account'.tr(),
                    style: const TextStyle(color: Colors.red)),
                onTap: () async {
                  // Show confirmation dialog
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('delete_account'.tr()),
                      content: Text('confirm_delete_account'.tr()),
                      actions: <Widget>[
                        TextButton(
                          child: Text('no'.tr()),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                          child: Text('yes'.tr()),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    ),
                  );

                  // if (confirm == true && context.mounted) {
                  //   context
                  //       .read<AuthBloc>()
                  //       .add(DeleteAccountAndRelatedDataEvent());
                  //   // Navigate back or to login screen after deletion
                  //   // Navigator.of(context).popUntil((route) => route.isFirst);
                  //   pushAndRemoveUntil(NamedRoutes.i.layoutView);
                  // }
                },
              ),
            ],
          ),
        ),
      );

  void _showLanguageDialog(BuildContext context, Locale currentLocale) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('language'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<Locale>(
              title: const Text('English'),
              value: const Locale('en'),
              groupValue: currentLocale,
              onChanged: (Locale? value) {
                if (value != null) {
                  context.read<SettingsBloc>().add(ChangeLanguage(value));
                  context.setLocale(value); // Update EasyLocalization locale
                  Navigator.of(context).pop();
                }
              },
            ),
            RadioListTile<Locale>(
              title: const Text('العربية'),
              value: const Locale('ar'),
              groupValue: currentLocale,
              onChanged: (Locale? value) {
                if (value != null) {
                  context.read<SettingsBloc>().add(ChangeLanguage(value));
                  context.setLocale(value); // Update EasyLocalization locale
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
