import 'package:flutter/material.dart';
import 'package:plant_plan/widgets/image_box.dart';

class ClearCard extends StatelessWidget {
  final String imageUri, title, action, day, time;
  final bool clear, dayBool;
  const ClearCard({
    Key? key,
    required this.imageUri,
    required this.title,
    required this.action,
    required this.day,
    required this.time,
    required this.dayBool,
    required this.clear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 6.0,
              spreadRadius: 0.0,
              offset: Offset(0, 1),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageBox(imageUri: imageUri, width: 40, height: 40),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color.fromRGBO(116, 159, 149, 1)),
                    ),
                    Text(
                      action,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: const Color.fromRGBO(2, 2, 2, 1)),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                dayBool
                    ? Row(
                        children: [
                          Text(
                            "$day $time",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color:
                                        const Color.fromRGBO(116, 159, 149, 1)),
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            time,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color:
                                        const Color.fromRGBO(116, 159, 149, 1)),
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                        ],
                      ),
                clear
                    ? Container(
                        height: 22,
                        width: 53,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 133, 63, 1),
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(12),
                              left: Radius.circular(12)),
                          border: Border.all(
                            width: 1,
                            color: const Color.fromRGBO(255, 133, 63, 1),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "CLEAR",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
