import 'dart:io';
import 'package:falatu/app/commons/bloc_states/files_state.dart';
import 'package:falatu/app/commons/config/constants.dart';
import 'package:falatu/app/commons/config/strings.dart';
import 'package:falatu/app/commons/enums/chat_files_type.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFilesBloc extends Cubit<FileState> {
  final FilePicker _filePicker;

  GetFilesBloc(this._filePicker) : super(InitialFileState());

  Future<void> call(ChatFilesType type) async {
    emit(LoadingFileState());

    dynamic fileType = FileType.any;
    List<String>? allowedExtensions;
    String messageType = '';

    switch (type) {
      case ChatFilesType.file:
        fileType = FileType.custom;
        allowedExtensions = allowedFileExtensions;
        messageType = Strings.documentType;
        break;
      case ChatFilesType.image:
        fileType = FileType.image;
        messageType = Strings.imageType;
        break;
      case ChatFilesType.video:
        fileType = FileType.video;
        messageType = Strings.videoType;
        break;
      default:
        return;
    }

    try {
      final FilePickerResult? picker = await _filePicker.pickFiles(
        allowedExtensions: allowedExtensions,
        allowMultiple: true,
        type: fileType,
      );
      List<File> files = [];

      if (picker != null) {
        files = picker.files.map<File>((e) => File(e.path!)).toList();
        emit(LoadedFileState(files, messageType));
      }
    } on PlatformException catch (e) {
      emit(ErrorFileState('Unsupported operation ${e.message}'));
    } catch (e) {
      emit(ErrorFileState(e.toString()));
    }
  }
}
