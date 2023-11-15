import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class FileState extends Equatable {}

class InitialFileState extends FileState {
  @override
  List<Object?> get props => [];
}

class LoadingFileState extends FileState {
  @override
  List<Object?> get props => [];
}

class LoadedFileState extends FileState {
  final List<File> files;
  final String type;

  LoadedFileState(this.files, this.type);
  @override
  List<Object?> get props => [files, type];
}

class ErrorFileState extends FileState {
  final String message;

  ErrorFileState(this.message);

  @override
  List<Object?> get props => [];
}
