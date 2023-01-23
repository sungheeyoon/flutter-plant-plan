import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(92.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(235, 247, 232, 1),
          title: Text('식물 추가',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: const Color.fromRGBO(29, 49, 91, 1))),
          centerTitle: true,
        ),
      ),
    );
  }
}
