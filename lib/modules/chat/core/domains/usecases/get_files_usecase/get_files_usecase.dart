import 'dart:io';

abstract class GetFilesUseCase {
  File getImagesFromGallery();

  File getImagesFromCamera();

  File getVideosFromGallery();

  File getVideosFromCamera();
}