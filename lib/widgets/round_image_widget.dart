import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  final String thumb, id;
  const RoundImage({super.key, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: id,
          child: Container(
            width: 64,
            height: 64,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: FittedBox(fit: BoxFit.fill, child: Image.network(thumb)),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          "이름이름이름",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: const Color.fromRGBO(29, 49, 91, 1)),
        ),
      ],
    );
  }
}
