import 'dart:typed_data';

class CatModel {
  final Uint8List payload;
  final DateTime from;

  const CatModel(this.payload, this.from);
}
