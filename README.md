# project_boilerplate

A Flutter project boilerplate.

## Getting Started

This project is a starting point for a Flutter application.

### to add new translations
run this `dart run easy_localization:generate -S .\assets\translations -f keys -O .\lib\generated -o locale_keys.g.dart`


### to add new assets
run this `flutter pub run build_runner build --delete-conflicting-outputs`

### to add new splash screen
run this `flutter pub run flutter_native_splash:create`

### to add new app icons
run this `flutter pub run flutter_launcher_icons:main`

### to add new package name
run this `dart run package_rename`





A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
