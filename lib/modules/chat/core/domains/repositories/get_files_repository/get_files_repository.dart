import 'dart:io';

abstract class GetFilesRepository {
  File getImagesFromGallery();

  File getImagesFromCamera();

  File getVideosFromGallery();

  File getVideosFromCamera();
}
