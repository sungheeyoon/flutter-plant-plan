import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(235, 247, 232, 1),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: const Color.fromRGBO(29, 49, 91, 1))),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
