import 'dart:math';

import 'package:flutter/material.dart';

class DefaultGrabbing extends StatelessWidget {
  final Color color;
  final bool reverse;

  const DefaultGrabbing(
      {Key? key, this.color = Colors.white, this.reverse = false})
      : super(key: key);

  BorderRadius _getBorderRadius() {
    var radius = const Radius.circular(25.0);
    return BorderRadius.only(
      topLeft: reverse ? Radius.zero : radius,
      topRight: reverse ? Radius.zero : radius,
      bottomLeft: reverse ? radius : Radius.zero,
      bottomRight: reverse ? radius : Radius.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            color: Color.fromRGBO(51, 103, 57, 0.06),
            offset: Offset(0, 3),
          )
        ],
        borderRadius: _getBorderRadius(),
        color: color,
      ),
      child: Transform.rotate(
        angle: reverse ? pi : 0,
        child: Stack(
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: Align(
                heightFactor: 4.0,
                child: Text(
                  "현재 모든 식물들이 건강해요!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: const Color.fromRGBO(2, 2, 2, 1)),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.7),
              child: _GrabbingIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

class _GrabbingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: Colors.grey[300],
      ),
      height: 4,
      width: 72,
    );
  }
}
