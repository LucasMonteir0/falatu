import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {}

class EmptyState extends BaseState {
  final String? message;

  EmptyState({this.message});

  @override
  List<Object?> get props => [message];
}

class LoadingState extends BaseState {
  @override
  List<Object?> get props => [];
}

class SuccessState<T> extends BaseState {
  final T data;

  SuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class ErrorState extends BaseState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
