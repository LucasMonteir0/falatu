import 'dart:io';
import 'package:falatu/modules/chat/core/domains/repositories/get_files_repository/get_files_repository.dart';
import 'package:falatu/modules/chat/core/domains/usecases/get_files_usecase/get_files_usecase.dart';

class GetFilesUseCaseImpl implements GetFilesUseCase {


  final GetFilesRepository repository;

  GetFilesUseCaseImpl(this.repository);
  @override
  File getImagesFromCamera() {
    return repository.getImagesFromCamera();
  }

  @override
  File getImagesFromGallery() {
    return repository.getImagesFromGallery();
  }

  @override
  File getVideosFromCamera() {
    return repository.getVideosFromCamera();
  }

  @override
  File getVideosFromGallery() {
    return repository.getVideosFromGallery();
  }
}