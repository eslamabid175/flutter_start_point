import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:project_boilerplate/app/platform/platform_service.dart';
import 'package:project_boilerplate/core/shared/theme/cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/layout/presentation/navigationController/navigation_bloc.dart';



final sl = GetIt.instance;

Future<void> initGitIt() async {
  // Core Services - Add this FIRST
  _initCoreServices();

  // External
  await _initExternal();
  _initializeTheme();
  // Features
//  await _initializeAuthFeature();
  await _initializeLayoutFeature();

}

void _initCoreServices() {
  // Register PlatformService as a singleton
  sl.registerLazySingleton<PlatformService>(() => PlatformServiceImpl());
}


Future<void> _initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // sl.registerLazySingleton(() => http.Client());
  //sl.registerLazySingleton(() => FirebaseMessaging.instance);
  // sl.registerLazySingleton(() => FlutterSecureStorage());
}

// Future<void> _initializeAuthFeature() async {
//   // Data Sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
//     sl(), // FirebaseAuth instance
//     sl(), // FirebaseFirestore instance
//   ));
// // repositories
//   sl.registerLazySingleton<AuthRepository>(
//           () => AuthRepositoryImpl(remoteDataSource: sl()));
//
// // Use cases
//   sl.registerLazySingleton(() => AuthUsecases(sl()));
// // Controllers
//   sl.registerFactory<LoginController>(() => LoginController(sl()));
// }

Future<void> _initializeLayoutFeature() async {
  // Navigation Bloc
  sl.registerLazySingleton<NavigationBloc>(() => NavigationBloc());
  // sl.registerLazySingleton<NavigationRepository>(() => NavigationRepositoryImpl());
  // sl.registerLazySingleton<NavigationUsecases>(() => NavigationUsecases(sl()));
}




Future<void> _initializeTheme() async {
  sl.registerFactory<ThemeCubit>(() => ThemeCubit());
}
