import 'package:flutter/material.dart';

class DummyBackgroundContent extends StatelessWidget {
  final accent = const Color(0xff8ba38d);

  const DummyBackgroundContent({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        height: 2100,
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.cyan.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.brown.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.cyan.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
