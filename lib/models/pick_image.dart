class PickImageResult {
  final List<int> _imageBytes;
  final String _base64String;
  final String _dataUri;

  List<int> get imageBytes => _imageBytes;
  String get base64String => _base64String;
  String get dataUri => _dataUri;

  PickImageResult(this._imageBytes, this._base64String, this._dataUri);
}
