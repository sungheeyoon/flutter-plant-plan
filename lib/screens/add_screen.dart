import 'package:flutter/material.dart';
import 'package:plant_plan/widgets/image_box.dart';

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
        child: Center(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: const [
                  ImageBox(
                      imageUri: 'assets/images/pot.png', width: 80, height: 80),
                  ImageBox(
                      imageUri: 'assets/icons/img.png', width: 20, height: 20)
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 180,
                child: TextField(
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: const Color.fromRGBO(29, 49, 91, 1)),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    suffixIconConstraints:
                        BoxConstraints(minHeight: 20, minWidth: 20),
                    suffixIcon: ImageBox(
                        imageUri: "assets/icons/search.png",
                        width: 1,
                        height: 1),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    hintText: '식물 이름 검색',
                    hintStyle: TextStyle(color: Color.fromRGBO(29, 49, 91, 1)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromRGBO(29, 49, 91, 1)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
