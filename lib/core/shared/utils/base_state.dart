import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  @override
  List<Object> get props => [];
}

class BaseInitial extends BaseState {}

class BaseLoading extends BaseState {}

class BaseLoaded<T> extends BaseState {
  final T response;

  BaseLoaded({required this.response});
}

class BaseError<String> extends BaseState {
  final String? message;

  BaseError({this.message});
}
