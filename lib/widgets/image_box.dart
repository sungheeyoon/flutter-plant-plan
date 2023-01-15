import 'package:flutter/cupertino.dart';

class ImageBox extends StatelessWidget {
  final String imageUri;
  final double width, height;
  const ImageBox(
      {super.key,
      required this.imageUri,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(imageUri),
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}
