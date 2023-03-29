import 'dart:io';

import 'package:falatu/modules/chat/core/data/datasources/local/get_files_datasource/get_files_datasource.dart';
import 'package:falatu/modules/chat/core/domains/repositories/get_files_repository/get_files_repository.dart';

class GetFilesRepositoryImpl implements GetFilesRepository{

  final GetFilesDatasource datasource;

  GetFilesRepositoryImpl(this.datasource);

  @override
  File getImagesFromCamera() {
 return datasource.getImagesFromCamera();
  }

  @override
  File getImagesFromGallery() {
    return datasource.getImagesFromGallery();
  }

  @override
  File getVideosFromCamera() {
    return datasource.getVideosFromCamera();
  }

  @override
  File getVideosFromGallery() {
    return datasource.getVideosFromGallery();
  }
}