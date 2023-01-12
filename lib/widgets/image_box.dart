import 'package:flutter/cupertino.dart';

class ImageBox extends StatelessWidget {
  final String imageUri;
  const ImageBox({super.key, required this.imageUri});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(imageUri),
      width: 70,
      height: 70,
      fit: BoxFit.fill,
    );
  }
}
