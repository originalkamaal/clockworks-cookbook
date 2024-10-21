import 'dart:convert';
import 'package:clockworks/models/pick_image.dart';
import 'package:http/http.dart' as http;

Future<PickImageResult> getImageBase64(String? imageUrl) async {
  if (imageUrl != null && imageUrl.isNotEmpty) {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final imageExtension = imageUrl.split('.').last;
      return PickImageResult(response.bodyBytes, base64Encode(response.bodyBytes), 'data:image/$imageExtension;base64,');
    }
  }
  throw Exception('Failed to load image: $imageUrl');
}
