import 'package:flutter_bloc/flutter_bloc.dart';

import '../depugging/debug_utils.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    Console.printSuccess('✨ Created: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    Console.printInfo('📮 Event: ${bloc.runtimeType} -> $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Console.printWarning('🔄 Change in ${bloc.runtimeType}:\n'
        '  Current: ${change.currentState}\n'
        '  Next: ${change.nextState}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Console.printColored(
      '➡️ Transition in ${bloc.runtimeType}:\n'
          '  Event: ${transition.event}\n'
          '  Current: ${transition.currentState}\n'
          '  Next: ${transition.nextState}',
      color: ConsoleColor.cyan,
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.error('🚨 Error in ${bloc.runtimeType}', error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    Console.printColored('🗑️ Closed: ${bloc.runtimeType}', color: ConsoleColor.magenta);
  }
}