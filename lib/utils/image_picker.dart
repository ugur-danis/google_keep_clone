import 'dart:io';

import 'package:image_picker/image_picker.dart' as image_picker;

abstract class IImagePicker {
  Future<File?> pickFromGallery();
}

class ImagePicker implements IImagePicker {
  @override
  Future<File?> pickFromGallery() async {
    final image_picker.ImagePicker picker = image_picker.ImagePicker();

    final image_picker.XFile? pickedFile = await picker.pickImage(
      source: image_picker.ImageSource.gallery,
    );

    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }
}
