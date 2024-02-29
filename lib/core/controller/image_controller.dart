import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pedo/constant/themes.dart';

class ImageController extends ChangeNotifier {
  ImagePicker imagePicker = ImagePicker();

  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;

  File takeImage() => File(pickedImage!.path);

  Future<void> pickImage() async {
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (_pickedImage == null) return;
    _pickedImage = await _cropImage(imageFile: _pickedImage);
    notifyListeners();
  }

  Future<XFile?> _cropImage({required XFile? imageFile}) async {
    ImageCropper imageCropper = ImageCropper();
    CroppedFile? croppedImage = await imageCropper.cropImage(
      sourcePath: imageFile!.path,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: colorPrimary,
            toolbarWidgetColor: colorLight,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedImage == null) return null;

    File(_pickedImage!.path).delete();
    return XFile(croppedImage.path);
  }

  Future<void> removeImage() async {
    _pickedImage = null;
    notifyListeners();
  }
}
