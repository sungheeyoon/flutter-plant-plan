import 'package:flutter/material.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/snapping_above.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool home;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.home,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        iconTheme: const IconThemeData(
          color: primary3Color, //색변경
        ),
        leading: IconButton(
            onPressed: () {
              if (home) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SnappingAbove(),
                    ));
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(235, 247, 232, 1),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: primary3Color)),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
