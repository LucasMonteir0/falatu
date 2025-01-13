import 'package:equatable/equatable.dart';

abstract class BaseError extends Error with EquatableMixin {
  final String message;
  final int code;

  BaseError({required this.message, this.code = -1});

  @override
  String toString() {
    return message;
  }
}
