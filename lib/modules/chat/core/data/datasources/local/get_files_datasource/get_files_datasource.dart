import 'dart:io';

abstract class GetFilesDatasource {

  File getImagesFromGallery();
  File getImagesFromCamera();
  File getVideosFromGallery();
  File getVideosFromCamera();
}