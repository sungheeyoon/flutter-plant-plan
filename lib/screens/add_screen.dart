import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/models/plant_model.dart';
import 'package:plant_plan/models/preserve_model.dart';
import 'package:plant_plan/screens/plant_search_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/image_helper.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AddScreen extends StatefulWidget {
  final PlantModel? document;
  final PreserveModel? prev;

  const AddScreen({Key? key, this.document, this.prev}) : super(key: key);
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  UploadTask? uploadTask;
  XFile? pickedFile;
  String? wateringDay;
  String? divisionDay;
  String? nutrientDay;
  String? alias;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final imageHelper = ImageHelper();
  bool _isButtonDisabled = true;
  final PageController _controller = PageController(initialPage: 0);

  Future uploadFile() async {
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      setState(() {
        uploadTask = referenceImageToUpload.putFile(File(pickedFile!.path));
      });
    } catch (error) {
      print(error);
    }
    final snapshot = await uploadTask!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      uploadTask = null;
    });
  }

  @override
  void initState() {
    if (widget.prev?.alias != null) {
      alias = '${widget.prev!.alias}';
    }
    if (widget.prev?.wateringDay != null) {
      wateringDay = '${widget.prev!.wateringDay}';
    }
    if (widget.prev?.divisionDay != null) {
      divisionDay = '${widget.prev!.divisionDay}';
    }
    if (widget.prev?.nutrientDay != null) {
      nutrientDay = '${widget.prev!.nutrientDay}';
    }
    if (widget.document?.name != null) {
      _isButtonDisabled = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;
    final fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(
        home: true,
        title: "식물추가",
      ),
      bottomNavigationBar: SizedBox(
        height: fullHeight * 0.068,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              disabledBackgroundColor: gray3Color,
              backgroundColor: primary3Color // Background color
              ),
          onPressed: _isButtonDisabled
              ? null
              : () {
                  if (wateringDay != null &&
                      divisionDay != null &&
                      nutrientDay != null) {
                    _controller.jumpToPage(1);
                  } else {
                    showDialog(
                      context: context,
                      builder: (ctx) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 32,
                              ),
                              Text('관리 날짜를 지정하지 않은 경우',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: grayBlack)),
                              Text('현재 식물을 추가한 날짜를 기준으로 적용됩니다',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: grayBlack)),
                              const SizedBox(
                                height: 32,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: gray4Color,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16)),
                                      child: Text('돌아가기',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(color: primary3Color))),
                                  TextButton(
                                      onPressed: () {
                                        _controller.jumpToPage(1);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('다음',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(color: primary3Color)))
                                ],
                              )
                            ],
                          )),
                    );
                  }
                  //_controller.jumpToPage(1);
                },
          child: Text("다음",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.white)),
        ),
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
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        final file = await imageHelper
                                            .pickImage(camera: true);
                                        if (file != null) {
                                          final croppedFile =
                                              await imageHelper.crop(
                                                  file: file,
                                                  cropStyle: CropStyle.circle);
                                          if (croppedFile != null) {
                                            setState(() {
                                              pickedFile =
                                                  XFile(croppedFile.path);
                                            });
                                          }
                                        }
                                      },
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
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        final file =
                                            await imageHelper.pickImage();
                                        if (file != null) {
                                          final croppedFile =
                                              await imageHelper.crop(
                                                  file: file,
                                                  cropStyle: CropStyle.circle);
                                          if (croppedFile != null) {
                                            setState(() {
                                              pickedFile =
                                                  XFile(croppedFile.path);
                                            });
                                          }
                                        }
                                      },
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
                            if (pickedFile != null) //찍은애
                              FittedBox(
                                  fit: BoxFit.contain,
                                  child: CircleAvatar(
                                      radius: 40, // Image radius
                                      backgroundImage:
                                          FileImage(File(pickedFile!.path))))
                            else if (widget.prev?.image != null) //찍엇는데 갔다왓음
                              FittedBox(
                                  fit: BoxFit.contain,
                                  child: CircleAvatar(
                                      radius: 40, // Image radius
                                      backgroundImage: FileImage(
                                          File(widget.prev!.image!.path))))
                            else if (widget.document != null) //안찍었는데 깟다왓어
                              FittedBox(
                                fit: BoxFit.contain,
                                child: CircleAvatar(
                                    radius: 40, // Image radius
                                    backgroundImage:
                                        NetworkImage(widget.document!.image)),
                              )
                            else
                              ImageBox(
                                  imageUri: 'assets/images/pot.png',
                                  width: fullWidth * 0.25,
                                  height: fullWidth * 0.25),
                            Positioned(
                              right: 1,
                              bottom: 1,
                              child: ImageBox(
                                imageUri: 'assets/icons/img.png',
                                width: fullWidth * 0.07,
                                height: fullWidth * 0.07,
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: fullHeight,
                child: PageView(
                  //physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("종류",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: primary3Color)),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                            width: fullWidth,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlantSearchScreen(
                                          prev: PreserveModel.fromJson({
                                        'image': pickedFile,
                                        'alias': alias,
                                        'wateringDay': wateringDay,
                                        'divisionDay': divisionDay,
                                        'nutrientDay': nutrientDay,
                                      })),
                                    ));
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                side: const BorderSide(
                                    width: 1, color: gray3Color), //<-- SEE HERE
                              ),
                              child: Row(
                                children: [
                                  const ImageBox(
                                      imageUri: 'assets/icons/search.png',
                                      width: 24,
                                      height: 24),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  widget.document != null
                                      ? Text('${widget.document?.name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(color: grayBlack))
                                      : Text('검색하기',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(color: gray2Color))
                                ],
                              ),
                            )),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text('식물 별칭',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: primary3Color))
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                alias = text;
                              });
                            },
                            initialValue: alias,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: grayBlack),
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 1, color: gray3Color)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: gray3Color, width: 1.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: gray3Color, width: 1.0)),
                                hintText: '선택사항',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: gray2Color)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage(
                                  "assets/images/management/humid.png"),
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text('수분량',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: primary3Color))
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            width: fullWidth,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () async {
                                DateTime? newDate = await showRoundedDatePicker(
                                  context: context,
                                  height: 400,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 1),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  borderRadius: 16,
                                );
                                if (newDate == null) return;

                                setState(() {
                                  wateringDay = formatter.format(newDate);
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                side: const BorderSide(
                                    width: 1, color: gray3Color), //<-- SEE HERE
                              ),
                              child: Row(
                                children: [
                                  const ImageBox(
                                      imageUri: 'assets/icons/calendar_box.png',
                                      width: 24,
                                      height: 24),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  if (wateringDay != null)
                                    Text(wateringDay.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: grayBlack))
                                  else if (widget.prev?.wateringDay != null)
                                    Text(widget.prev!.wateringDay.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: grayBlack))
                                  else
                                    Text('마지막으로 물 준 날',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: gray2Color))
                                ],
                              ),
                            )),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage(
                                  "assets/images/management/division.png"),
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text('분갈이',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: primary3Color))
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            width: fullWidth,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () async {
                                DateTime? newDate = await showRoundedDatePicker(
                                  context: context,
                                  height: 400,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 1),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  borderRadius: 16,
                                );
                                if (newDate == null) return;

                                setState(() {
                                  divisionDay = formatter.format(newDate);
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                side: const BorderSide(
                                    width: 1, color: gray3Color), //<-- SEE HERE
                              ),
                              child: Row(
                                children: [
                                  const ImageBox(
                                      imageUri: 'assets/icons/calendar_box.png',
                                      width: 24,
                                      height: 24),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  if (divisionDay != null)
                                    Text(divisionDay.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: grayBlack))
                                  else if (widget.prev?.divisionDay != null)
                                    Text(widget.prev!.divisionDay.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: grayBlack))
                                  else
                                    Text('마지막으로 분갈이 한 날',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: gray2Color))
                                ],
                              ),
                            )),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Image(
                              image: AssetImage(
                                  "assets/images/management/nutrient.png"),
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text('영양제',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: primary3Color))
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            width: fullWidth,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () async {
                                DateTime? newDate = await showRoundedDatePicker(
                                  context: context,
                                  height: 400,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 1),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  borderRadius: 16,
                                );
                                if (newDate == null) return;

                                setState(() {
                                  nutrientDay = formatter.format(newDate);
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                side: const BorderSide(
                                    width: 1, color: gray3Color), //<-- SEE HERE
                              ),
                              child: Row(
                                children: [
                                  const ImageBox(
                                      imageUri: 'assets/icons/calendar_box.png',
                                      width: 24,
                                      height: 24),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  if (nutrientDay != null)
                                    Text(nutrientDay.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: grayBlack))
                                  else if (widget.prev?.nutrientDay != null)
                                    Text(widget.prev!.nutrientDay.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: grayBlack))
                                  else
                                    Text('마지막으로 영양제 준 날',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: gray2Color))
                                ],
                              ),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Text("주기 설정",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    color:
                                        const Color.fromRGBO(29, 49, 91, 1))),
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
                  ],
                ),
              ),
              ElevatedButton(onPressed: uploadFile, child: const Text("버툰")),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
            height: 78,
            decoration: BoxDecoration(
                color: gray5Color, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text("$title 알람을 설정하세요",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: primary3Color)),
            )),
      ],
    );
  }
}
