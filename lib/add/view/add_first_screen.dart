import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/plant_provider.dart';
import 'package:plant_plan/add/view/search_screen.dart';
import 'package:plant_plan/common/widget/rounded_button.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/image_helper.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AddFirstScreen extends ConsumerStatefulWidget {
  const AddFirstScreen({
    super.key,
  });

  @override
  ConsumerState<AddFirstScreen> createState() => _AddFirstScreenState();
}

class _AddFirstScreenState extends ConsumerState<AddFirstScreen> {
  @override
  Widget build(BuildContext context) {
    String? alias;
    String? wateringDay;
    String? divisionDay;
    String? nutrientDay;

    final TextEditingController wateringDayController = TextEditingController();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    List<DateTime?> singleDatePickerValueWithDefaultValue = [
      DateTime.now(),
    ];
    final selectedPlant = ref.watch(selectedPlantProvider);
    final selectedPhoto = ref.watch(photoProvider);
    final imageHelper = ImageHelper();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8.0,
            ),
            // top prograss bar
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 34,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: keyColor500,
                        child: Text(
                          '1',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        indent: 6.0,
                        endIndent: 6.0,
                        thickness: 1,
                        color: keyColor300,
                      ),
                    ),
                    const SizedBox(
                      width: 34,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: keyColor300,
                        child: CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        indent: 6.0,
                        endIndent: 6.0,
                        thickness: 1,
                        color: keyColor300,
                      ),
                    ),
                    const SizedBox(
                      width: 34,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: keyColor300,
                        child: CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 34,
                      child: Text(
                        '정보추가',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: keyColor600,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 34,
                      child: Text(
                        '알림추가',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: keyColor400,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 34,
                      child: Text(
                        '추가완료',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: keyColor400,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            // photo and search box
            Center(
              child: Container(
                width: 360.w,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: grayBlack.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(2, 2), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Stack(
                          children: [
                            if (selectedPhoto != null) //찍은애
                              Stack(children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: CircleAvatar(
                                    radius: 40, // Image radius
                                    backgroundImage: FileImage(selectedPhoto),
                                  ),
                                ),
                                Positioned(
                                  right: 1,
                                  top: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      ref.read(photoProvider.notifier).reset();
                                    },
                                    child: const ImageBox(
                                      imageUri: 'assets/icons/x.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ])
                            else if (selectedPlant != null) //안찍었는데 깟다왓어
                              FittedBox(
                                fit: BoxFit.contain,
                                child: CircleAvatar(
                                  radius: 40, // Image radius
                                  backgroundImage:
                                      NetworkImage(selectedPlant.image),
                                ),
                              )
                            else
                              const ImageBox(
                                imageUri: 'assets/images/pot.png',
                                width: 80,
                                height: 80,
                              ),
                          ],
                        ),
                      ],
                    ),
                    if (selectedPlant != null)
                      Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            selectedPlant.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: grayBlack,
                                ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SearchScreen(),
                              ),
                            );
                          },
                          backgroundColor: Colors.white,
                          borderColor: pointColor2.withOpacity(
                            0.5,
                          ),
                          width: 136,
                          height: 32,
                          textColor: pointColor2,
                          name: '종류 검색',
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        RoundedButton(
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
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
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      final file = await imageHelper.pickImage(
                                          camera: true);
                                      if (file != null) {
                                        final croppedFile =
                                            await imageHelper.crop(
                                                file: file,
                                                cropStyle: CropStyle.circle);
                                        if (croppedFile != null) {
                                          ref
                                              .read(photoProvider.notifier)
                                              .setPhoto(croppedFile.path);
                                        }
                                      }
                                    },
                                    child: Align(
                                      alignment: const Alignment(-1.0, 0.0),
                                      child: Text(
                                        "카메라",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
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
                                          ref
                                              .read(photoProvider.notifier)
                                              .setPhoto(croppedFile.path);
                                        }
                                      }
                                    },
                                    child: Align(
                                      alignment: const Alignment(-1.0, 0.0),
                                      child: Text(
                                        "갤러리 사진 선택",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: grayColor700,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          borderColor: pointColor2.withOpacity(
                            0.5,
                          ),
                          width: 136,
                          height: 32,
                          textColor: pointColor2,
                          name: '사진 추가',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            //별칭
            Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextField(
                    onChanged: (text) {
                      setState(
                        () {
                          alias = text;
                        },
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16),
                      hintText: '내 식물의 별칭을 입력해주세요',
                      hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: grayColor400,
                              ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: keyColor500,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: grayColor400,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 0,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: Text('별칭(선택)',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: grayColor600,
                                  )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            //물주기 ontap version
            GestureDetector(
              onTap: () async {
                final values = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(),
                  dialogSize: const Size(325, 400),
                  value: singleDatePickerValueWithDefaultValue,
                  borderRadius: BorderRadius.circular(15),
                );
                if (values != null) {
                  // ignore: avoid_print
                  setState(() {
                    wateringDay = formatter.format(values[0]!);
                    print('print watringggg $wateringDay');
                  });
                }
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextField(
                      enabled: false,
                      controller: wateringDayController,
                      onChanged: (value) {
                        setState(
                          () {
                            if (wateringDay != null) {
                              value = wateringDay!;
                            }
                          },
                        );
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 16),
                        hintText: wateringDay ?? '마지막으로 물 준 날을 선택해주세요',
                        hintStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: grayColor400,
                                ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: keyColor500,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: grayColor400,
                          ),
                        ),
                        disabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: grayColor400)),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 0,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                        ),
                        child: Text(
                          '물주기',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: grayColor600,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 13,
                    child: Container(
                      color: Colors.white,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.0,
                        ),
                        child: ImageBox(
                          imageUri: 'assets/icons/calendar_box.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ElevatedButton(
            //     onPressed: uploadFile, child: const Text("예비 업로드버튼")),
          ],
        ),
      ),
    );
  }
}
