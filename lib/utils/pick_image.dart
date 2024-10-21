import 'dart:convert';

import 'package:clockworks/models/pick_image.dart';
import 'package:image_picker/image_picker.dart';

Future<PickImageResult> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final imageBytes = await pickedFile.readAsBytes();

    final fileExtension = pickedFile.path.split('.').last;

    return PickImageResult(imageBytes, base64Encode(imageBytes), 'data:image/$fileExtension;base64,${base64Encode(imageBytes)}');
  }
  throw Exception('No image selected');
}
