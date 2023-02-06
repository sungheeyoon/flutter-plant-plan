import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';

class PlantSearchScreen extends StatelessWidget {
  const PlantSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "식물검색", home: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: gray4Color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 20,
                  color: gray2Color,
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: grayBlack),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: gray4Color),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: gray4Color),
                      ),
                      isCollapsed: true,
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
