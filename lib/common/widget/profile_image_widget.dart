import 'package:flutter/material.dart';
import 'package:plant_plan/utils/colors.dart';

class ProfileImageWidget extends StatelessWidget {
  final ImageProvider imageProvider;
  final double size;
  final double radius;
  const ProfileImageWidget({
    super.key,
    required this.imageProvider,
    required this.size,
    required this.radius,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: grayColor200,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: imageProvider,
        ),
      ),
    );
  }
}
