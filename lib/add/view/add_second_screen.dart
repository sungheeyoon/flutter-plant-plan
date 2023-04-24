import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/add/provider/plant_provider.dart';
import 'package:plant_plan/add/view/alarm_screen.dart';
import 'package:plant_plan/add/widget/progress_bar.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';
import 'package:plant_plan/common/widget/rounded_button.dart';

class AddSecondScreen extends ConsumerWidget {
  const AddSecondScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlant = ref.watch(selectedPlantProvider);
    final selectedPhoto = ref.watch(photoProvider);
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
            const ProgressBar(pageIndex: 1),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                width: 360.w,
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.h),
                  boxShadow: [
                    BoxShadow(
                      color: grayBlack.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(2, 2), // Shadow position
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (selectedPhoto != null) //찍은애
                          Stack(children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: CircleAvatar(
                                radius: 18.h, // Image radius
                                backgroundImage: FileImage(selectedPhoto),
                              ),
                            ),
                          ])
                        else if (selectedPlant != null) //안찍었는데 깟다왓어
                          FittedBox(
                            fit: BoxFit.contain,
                            child: CircleAvatar(
                              radius: 18.h, // Image radius
                              backgroundImage:
                                  NetworkImage(selectedPlant.image),
                            ),
                          )
                        else
                          ImageBox(
                            imageUri: 'assets/images/pot.png',
                            width: 36.h,
                            height: 36.h,
                          ),
                        SizedBox(
                          width: 12.h,
                        ),
                        if (selectedPlant != null)
                          Text(
                            selectedPlant.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: grayBlack,
                                ),
                          ),
                      ],
                    ),
                    RoundedButton(
                      font: Theme.of(context).textTheme.labelMedium,
                      backgroundColor: Colors.white,
                      borderColor: pointColor2.withOpacity(
                        0.5,
                      ),
                      width: 52.h,
                      height: 26.h,
                      textColor: pointColor2,
                      name: '변경',
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.timer_outlined, // 플러스 아이콘
                  size: 32.h, // 아이콘 크기 설정
                  color: pointColor2, // 아이콘 색상 설정
                ),
                SizedBox(
                  width: 8.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '식물 상태에 따라 관리 주기를',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: pointColor2,
                          ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      '원하는대로 설정하고 알림을 받아보세요',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: pointColor2,
                          ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            const AlarmBox(
                iconPath: 'assets/images/management/humid.png',
                title: '물주기',
                field: PlantField.watering),
            SizedBox(
              height: 12.h,
            ),
            const AlarmBox(
                iconPath: 'assets/images/management/repotting.png',
                title: '분갈이',
                field: PlantField.repotting),
            SizedBox(
              height: 12.h,
            ),
            const AlarmBox(
                iconPath: 'assets/images/management/nutrient.png',
                title: '영양제',
                field: PlantField.nutrient),
            SizedBox(
              height: 12.h,
            ),
            Text(
              '앱 알림 권한을 허용해야 정상적인 알림 서비스를 이용하실 수 있어요',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: grayColor500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class AlarmBox extends StatelessWidget {
  final String iconPath;
  final String title;
  final PlantField field;
  const AlarmBox({
    super.key,
    required this.iconPath,
    required this.title,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlarmScreen(
              title: title,
              field: field,
            ),
          ),
        );
      },
      child: Center(
        child: Container(
          width: 360.w,
          padding: EdgeInsets.all(16.h),
          decoration: BoxDecoration(
            color: grayColor100,
            borderRadius: BorderRadius.circular(16.h),
            border: Border.all(
              width: 1.h,
              color: grayColor300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    iconPath,
                    width: 20.h,
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grayBlack,
                        ),
                  )
                ],
              ),
              CircleAvatar(
                radius: 8.h,
                backgroundColor: pointColor2,
                child: Icon(
                  Icons.add, // 플러스 아이콘
                  size: 16.h, // 아이콘 크기 설정
                  color: Colors.white, // 아이콘 색상 설정
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
