import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:plant_plan/screens/plant_search_screen.dart';
import 'package:plant_plan/screens/snapping_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    await uploadTask!.whenComplete(() => {});
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "식물추가",
        home: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              builder: (context) => Container(
                                padding:
                                    const EdgeInsets.fromLTRB(32, 24, 32, 25),
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
                                    0.25,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("식물 사진 변경",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: grayBlack)),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {},
                                      child: Align(
                                        alignment: const Alignment(-1.0, 0.0),
                                        child: Text("카메라",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: gray1Color)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: selectFile,
                                      child: Align(
                                        alignment: const Alignment(-1.0, 0.0),
                                        child: Text("갤러리 사진 선택",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: gray1Color)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Stack(children: [
                            if (pickedFile != null)
                              CircleAvatar(
                                radius: 40, // Image radius
                                backgroundImage:
                                    FileImage(File(pickedFile!.path!)),
                              )
                            else
                              const ImageBox(
                                  imageUri: 'assets/images/pot.png',
                                  width: 80,
                                  height: 80),
                            const Positioned(
                              right: 1,
                              bottom: 1,
                              child: ImageBox(
                                  imageUri: 'assets/icons/img.png',
                                  width: 20,
                                  height: 20),
                            )
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          backgroundColor: sub1Color,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          side: const BorderSide(
                              width: 0, color: sub1Color), //<-- SEE HERE
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PlantSearchScreen(),
                              ));
                        },
                        child: Text("식물 이름 검색",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white))),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(children: const [
                      SnappingContainer(
                          imageUrl: "assets/images/management/humid.png",
                          title: "수분량",
                          measure: "88%",
                          explain: "모든 식물이들 수분 충분해요"),
                      SizedBox(
                        width: 10,
                      ),
                      SnappingContainer(
                          imageUrl: "assets/images/management/sun.png",
                          title: "일조량",
                          measure: "75%",
                          explain: "모든 식물이들 일조량 충분해요"),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: const [
                      SnappingContainer(
                          imageUrl: "assets/images/management/division.png",
                          title: "분갈이",
                          measure: "D-120",
                          explain: "분갈이 시기 확인하세요"),
                      SizedBox(
                        width: 10,
                      ),
                      SnappingContainer(
                          imageUrl: "assets/images/management/nutrient.png",
                          title: "영양제",
                          measure: "D-80",
                          explain: "영양제 종류/목적 중요해요")
                    ])
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text("주기 설정",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: const Color.fromRGBO(29, 49, 91, 1))),
                  const SizedBox(
                    height: 16,
                  ),
                  const SettingCard(title: "물주기"),
                  const SizedBox(
                    height: 21,
                  ),
                  const SettingCard(title: "분갈이"),
                  const SizedBox(
                    height: 21,
                  ),
                  const SettingCard(title: "영양제"),
                  const SizedBox(
                    height: 141,
                  ),
                ],
              ),
              ElevatedButton(onPressed: uploadFile, child: const Text("버툰"))
            ],
          ),
        ),
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  final String title;
  const SettingCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 22,
              width: 53,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 133, 63, 1),
                borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(10), left: Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: const Color.fromRGBO(255, 133, 63, 1),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              width: 240,
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
                      imageUri: "assets/icons/pen.png", width: 1, height: 1),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color.fromRGBO(29, 49, 91, 1)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
            height: 78,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(245, 245, 245, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text("$title 알람을 설정하세요"),
            )),
      ],
    );
  }
}
