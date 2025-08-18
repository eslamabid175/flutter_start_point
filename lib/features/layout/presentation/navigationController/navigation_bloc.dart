import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presntation/screens/home_screen.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<NavigateToPage>(_onNavigateToPage);
  }

  void _onNavigateToPage(NavigateToPage event, Emitter<NavigationState> emit) {
    emit(NavigationState(event.index));
  }

  Widget get currentPage => getSelectedPage(state.currentIndex);

  Widget getSelectedPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const Center(child: Text('1'));
      case 2:
        return const Center(child: Text('2'));
      case 3:
        return const Center(child: Text('3'));
      case 4:
        return const Center(child: Text('4'));
      default:
        return const Center(child: Text('0'));
    }
  }
}
