import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/add/view/add_first_screen.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/rounded_button.dart';
import 'package:plant_plan/models/plant_model.dart';
import 'package:plant_plan/models/preserve_model.dart';
import 'package:plant_plan/screens/alarm_screen.dart';
import 'package:plant_plan/add/view/search_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/image_helper.dart';
import 'package:plant_plan/utils/sizes_helpers.dart';

import 'package:plant_plan/widgets/image_box.dart';

class AddTab extends ConsumerStatefulWidget {
  static String get routeName => 'add';
  final PlantModel? document;
  final PreserveModel? prev;

  const AddTab({Key? key, this.document, this.prev}) : super(key: key);
  @override
  ConsumerState<AddTab> createState() => _AddTabState();
}

class _AddTabState extends ConsumerState<AddTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;
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
  int bottomSelectedIndex = 0;

  FocusNode focusNode = FocusNode();
  bool isFocused = false;

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

    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  Widget buildPageView(context) {
    return PageView(
      //physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("종류",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: primaryColor)),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              width: displayWidth(context),
              height: 40,
              child: OutlinedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  side: const BorderSide(
                      width: 1, color: grayColor400), //<-- SEE HERE
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
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('식물 별칭',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: primaryColor))
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
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(width: 1, color: grayColor400)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: grayColor400, width: 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: grayColor400, width: 1.0)),
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
                  image: AssetImage("assets/images/management/humid.png"),
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
                        .copyWith(color: primaryColor))
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
                width: displayWidth(context),
                height: 40,
                child: OutlinedButton(
                  onPressed: () async {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    side: const BorderSide(
                        width: 1, color: grayColor400), //<-- SEE HERE
                  ),
                  child: Row(
                    children: [
                      const ImageBox(
                        imageUri: 'assets/icons/calendar_box.png',
                        width: 24,
                        height: 24,
                      ),
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
                  image: AssetImage("assets/images/management/division.png"),
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
                        .copyWith(color: primaryColor))
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
                width: displayWidth(context),
                height: 40,
                child: OutlinedButton(
                  onPressed: () async {
                    // DateTime? newDate = await showRoundedDatePicker(
                    //   context: context,
                    //   height: 400,
                    //   initialDate: DateTime.now(),
                    //   firstDate: DateTime(DateTime.now().year - 1),
                    //   lastDate: DateTime(DateTime.now().year + 1),
                    //   borderRadius: 16,
                    // );
                    // if (newDate == null) return;

                    // setState(() {
                    //   divisionDay = formatter.format(newDate);
                    // });
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    side: const BorderSide(
                        width: 1, color: grayColor400), //<-- SEE HERE
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
                  image: AssetImage("assets/images/management/nutrient.png"),
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
                        .copyWith(color: primaryColor))
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
                width: displayWidth(context),
                height: 40,
                child: OutlinedButton(
                  onPressed: () async {
                    // DateTime? newDate = await showRoundedDatePicker(
                    //   context: context,
                    //   height: 400,
                    //   initialDate: DateTime.now(),
                    //   firstDate: DateTime(DateTime.now().year - 1),
                    //   lastDate: DateTime(DateTime.now().year + 1),
                    //   borderRadius: 16,
                    // );
                    // if (newDate == null) return;

                    // setState(() {
                    //   nutrientDay = formatter.format(newDate);
                    // });
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    side: const BorderSide(
                        width: 1, color: grayColor400), //<-- SEE HERE
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
                )),
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
                    .copyWith(color: const Color.fromRGBO(29, 49, 91, 1))),
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
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '식물추가',
      floatingActionButton: RoundedButton(
        backgroundColor: pointColor2,
        borderColor: pointColor2.withOpacity(
          0.5,
        ),
        width: 328.w,
        height: 44,
        textColor: Colors.white,
        name: '다음',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // bottomNavigationBar: SizedBox(
      //   width: fullWidth,
      //   height: fullHeight * 0.068,
      //   child: bottomSelectedIndex == 0
      //       ? ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //               disabledBackgroundColor: grayColor400,
      //               backgroundColor: point1Color // Background color
      //               ),
      //           onPressed: _isButtonDisabled
      //               ? null
      //               : () {
      //                   if (wateringDay != null &&
      //                       divisionDay != null &&
      //                       nutrientDay != null) {
      //                     _controller.jumpToPage(1);
      //                   } else {
      //                     dialog(context);
      //                   }
      //                 },
      //           child: Text("다음",
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .headlineLarge!
      //                   .copyWith(color: Colors.white)),
      //         )
      //       : Column(
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Expanded(
      //                   child: Container(
      //                     height: fullHeight * 0.068,
      //                     decoration: const BoxDecoration(
      //                         border: Border(
      //                             top: BorderSide(
      //                                 width: 1, color: point1Color))),
      //                     child: Center(
      //                       child: TextButton(
      //                           onPressed: () {
      //                             _controller.jumpToPage(0);
      //                           },
      //                           style: TextButton.styleFrom(
      //                               padding: const EdgeInsets.symmetric(
      //                                   vertical: 16)),
      //                           child: Text('이전',
      //                               style: Theme.of(context)
      //                                   .textTheme
      //                                   .headlineLarge!
      //                                   .copyWith(color: point1Color))),
      //                     ),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     height: fullHeight * 0.068,
      //                     color: point1Color,
      //                     child: Center(
      //                       child: TextButton(
      //                           onPressed: () {},
      //                           style: TextButton.styleFrom(
      //                             minimumSize: Size.zero,
      //                             padding: EdgeInsets.zero,
      //                             tapTargetSize:
      //                                 MaterialTapTargetSize.shrinkWrap,
      //                           ),
      //                           child: Text('식물 추가 완료',
      //                               style: Theme.of(context)
      //                                   .textTheme
      //                                   .headlineLarge!
      //                                   .copyWith(color: Colors.white))),
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             )
      //           ],
      //         ),
      // ),
      child: const AddFirstScreen(),
    );
  }

  Future<dynamic> showMoadl(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("식물 사진 변경",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: grayBlack)),
            const SizedBox(
              height: 32,
            ),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                Navigator.pop(context);
                final file = await imageHelper.pickImage(camera: true);
                if (file != null) {
                  final croppedFile = await imageHelper.crop(
                      file: file, cropStyle: CropStyle.circle);
                  if (croppedFile != null) {
                    setState(() {
                      pickedFile = XFile(croppedFile.path);
                    });
                  }
                }
              },
              child: Align(
                alignment: const Alignment(-1.0, 0.0),
                child: Text(
                  "카메라",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: grayColor700,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                Navigator.pop(context);
                final file = await imageHelper.pickImage();
                if (file != null) {
                  final croppedFile = await imageHelper.crop(
                      file: file, cropStyle: CropStyle.circle);
                  if (croppedFile != null) {
                    setState(() {
                      pickedFile = XFile(croppedFile.path);
                    });
                  }
                }
              },
              child: Align(
                alignment: const Alignment(-1.0, 0.0),
                child: Text(
                  "갤러리 사진 선택",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: grayColor700,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dialog(BuildContext context) {
    return showDialog(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: Text('돌아가기',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: primaryColor))),
                  TextButton(
                      onPressed: () {
                        _controller.jumpToPage(1);
                        Navigator.of(context).pop();
                      },
                      child: Text('다음',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: primaryColor)))
                ],
              )
            ],
          )),
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
                color: point1Color,
                borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(10), left: Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: point1Color,
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
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AlarmScreen()));
          },
          child: Container(
              height: 78,
              decoration: BoxDecoration(
                  color: gray5Color, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text("$title 알람을 설정하세요",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: primaryColor)),
              )),
        ),
      ],
    );
  }
}
