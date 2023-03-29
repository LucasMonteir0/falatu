import 'dart:io';
import 'package:falatu/modules/chat/core/data/datasources/local/get_files_datasource/get_files_datasource.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDatasourceImpl implements GetFilesDatasource{
  const ImagePickerDatasourceImpl(this.imagePicker);

  final ImagePicker imagePicker;

  @override
  File getImagesFromCamera() {
    return File('');
  }

  @override
  File getImagesFromGallery() {
    return File('');
  }

  @override
  File getVideosFromCamera() {
    return File('');
  }

  @override
  File getVideosFromGallery() {
    return File('');
  }

}