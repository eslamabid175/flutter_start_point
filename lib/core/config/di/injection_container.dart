import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/layout/presentation/navigationController/navigation_bloc.dart';
import '../../../features/settings/presentation/viewModel/settings_bloc.dart';
import '../../shared/theme/cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  await _initExternal();
  await _initializeLayoutFeature();
  await _initializeSettingsFeature();
  // Features
  //   await _initializeAuthFeature();
  //   await _initializeLayoutFeature();
}

Future<void> _initExternal() async {
  // Register SharedPreferences (async, so we await it)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

Future<void> _initializeLayoutFeature() async {
  // Navigation Bloc
  sl.registerFactory<NavigationBloc>(() => NavigationBloc());
  // sl.registerLazySingleton<NavigationRepository>(() => NavigationRepositoryImpl());
  // sl.registerLazySingleton<NavigationUsecases>(() => NavigationUsecases(sl()));
}

Future<void> _initializeSettingsFeature() async {
  // Settings Bloc
  sl.registerFactory<SettingsBloc>(() => SettingsBloc());
  // sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl());
  // sl.registerLazySingleton<SettingsUsecases>(() => SettingsUsecases(sl()));
}

Future<void> _initializeTheme() async {
  sl.registerFactory<ThemeCubit>(() => ThemeCubit());
}
