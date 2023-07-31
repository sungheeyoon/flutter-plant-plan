import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/add/provider/plant_provider.dart';
import 'package:plant_plan/add/view/add_second_screen.dart';
import 'package:plant_plan/add/view/search_screen.dart';
import 'package:plant_plan/add/widget/date_picker_widget.dart';
import 'package:plant_plan/add/widget/progress_bar.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/rounded_button.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/image_helper.dart';

class AddFirstScreen extends ConsumerStatefulWidget {
  static String get routeName => 'addFirst';
  const AddFirstScreen({
    super.key,
  });

  @override
  ConsumerState<AddFirstScreen> createState() => _AddFirstScreenState();
}

class _AddFirstScreenState extends ConsumerState<AddFirstScreen> {
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final PlantInformationModel plantState = ref.read(plantInformationProvider);
    textController.text = plantState.alias;
    // TextEditingController 생성
  }

  @override
  void dispose() {
    // TextEditingController 해제
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPlant = ref.watch(selectedPlantProvider);
    final selectedPhoto = ref.watch(photoProvider);
    final imageHelper = ImageHelper();

    return DefaultLayout(
      title: '식물추가',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          ref.read(selectedPlantProvider.notifier).reset();
          ref.read(photoProvider.notifier).reset();
          ref.read(alarmProvider.notifier).reset();
          ref.read(plantInformationProvider.notifier).reset();
          Navigator.pop(context);
        },
      ),
      floatingActionButton: RoundedButton(
        font: Theme.of(context).textTheme.bodyLarge,
        backgroundColor: selectedPlant != null ? pointColor2 : grayColor300,
        borderColor: selectedPlant != null
            ? pointColor2.withOpacity(
                0.5,
              )
            : grayColor300,
        width: 328.w,
        height: 44.h,
        textColor: Colors.white,
        name: '다음',
        onPressed: () async {
          if (selectedPlant != null) {
            Navigator.pushNamed(context, AddSecondScreen.routeName);
          }
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              // top prograss bar
              const ProgressBar(pageIndex: 0),

              SizedBox(
                height: 20.h,
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
                                      radius: 40.h, // Image radius
                                      backgroundImage: FileImage(selectedPhoto),
                                    ),
                                  ),
                                  Positioned(
                                    right: 1,
                                    top: 1,
                                    child: GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(photoProvider.notifier)
                                              .reset();
                                        },
                                        child: Image(
                                          image: const AssetImage(
                                              'assets/icons/x.png'),
                                          width: 20.h,
                                          height: 20.h,
                                        )),
                                  ),
                                ])
                              else if (selectedPlant != null) //안찍었는데 갔다옴
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: CircleAvatar(
                                    radius: 40.h, // Image radius
                                    backgroundImage:
                                        NetworkImage(selectedPlant.image),
                                  ),
                                )
                              else
                                Image(
                                  image:
                                      const AssetImage('assets/images/pot.png'),
                                  width: 80.h,
                                  height: 80.h,
                                )
                            ],
                          ),
                        ],
                      ),
                      if (selectedPlant != null)
                        Column(
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              selectedPlant.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: grayBlack,
                                  ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SearchScreen.routeName);
                            },
                            font: Theme.of(context).textTheme.labelMedium,
                            backgroundColor: Colors.white,
                            borderColor: pointColor2.withOpacity(
                              0.5,
                            ),
                            width: 136,
                            height: 30.h,
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
                                height: 180.h,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("식물 사진 추가",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: grayBlack)),
                                    SizedBox(
                                      height: 32.h,
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
                                    SizedBox(
                                      height: 20.h,
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
                            font: Theme.of(context).textTheme.labelMedium,
                            backgroundColor: Colors.white,
                            borderColor: pointColor2.withOpacity(
                              0.5,
                            ),
                            width: 136,
                            height: 30.h,
                            textColor: pointColor2,
                            name: '사진 추가',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              //별칭
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      controller: textController,
                      onChanged: (text) {
                        ref
                            .read(plantInformationProvider.notifier)
                            .updateAlias(text);
                      },
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: grayBlack),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 16),
                        hintText: '내 식물의 별칭을 입력해주세요',
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                          '별칭',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: grayColor600,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20.h,
              ),
              //물주기 ontap version
              const DatePickerWidget(
                field: PlantField.watering,
                hintText: '마지막으로 물 준 날을 선택해주세요',
                labelText: '물주기',
              ),

              SizedBox(
                height: 20.h,
              ),
              const DatePickerWidget(
                field: PlantField.repotting,
                hintText: '마지막으로 분갈이 한 날을 선택해주세요',
                labelText: '분갈이',
              ),
              SizedBox(
                height: 20.h,
              ),
              const DatePickerWidget(
                field: PlantField.nutrient,
                hintText: '마지막으로 영양제 준 날을 선택해주세요',
                labelText: '영양제',
              ),

              // ElevatedButton(
              //     onPressed: uploadFile, child: const Text("예비 업로드버튼")),
            ],
          ),
        ),
      ),
    );
  }
}
