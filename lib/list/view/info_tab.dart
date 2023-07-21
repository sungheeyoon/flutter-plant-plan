import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/add/view/add_second_screen.dart';
import 'package:plant_plan/utils/colors.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "다가오는 알림",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: primaryColor),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //다가오는 알림 컨테이너
              Container(
                width: 98.h,
                height: 110.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.h),
                  border: Border.all(
                    color: const Color(0xFFAAE2F3),
                    width: 1.h,
                  ),
                ),
                padding: EdgeInsets.all(16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/management/humid.png',
                      width: 28.h,
                      height: 28.h,
                    ),
                    Text(
                      "다가오는 알림",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: const Color(0xFF72CBE7),
                          ),
                    ),
                    Text(
                      "TODAY",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: grayBlack,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 98.h,
                height: 110.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.h),
                  border: Border.all(
                    color: const Color(0xFFAAE2F3),
                    width: 1.h,
                  ),
                ),
                padding: EdgeInsets.all(16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/management/humid.png',
                      width: 28.h,
                      height: 28.h,
                    ),
                    Text(
                      "다가오는 알림",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: const Color(0xFF72CBE7),
                          ),
                    ),
                    Text(
                      "TODAY",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: grayBlack,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 98.h,
                height: 110.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.h),
                  border: Border.all(
                    color: const Color(0xFFAAE2F3),
                    width: 1.h,
                  ),
                ),
                padding: EdgeInsets.all(16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/management/humid.png',
                      width: 28.h,
                      height: 28.h,
                    ),
                    Text(
                      "다가오는 알림",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: const Color(0xFF72CBE7),
                          ),
                    ),
                    Text(
                      "TODAY",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: grayBlack,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            "알림 설정",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: primaryColor),
          ),
          SizedBox(
            height: 12.h,
          ),
          const AlarmBox(
            iconPath: 'assets/images/management/humid.png',
            title: '물주기',
            field: PlantField.watering,
          ),
          SizedBox(
            height: 12.h,
          ),
          const AlarmBox(
            iconPath: 'assets/images/management/repotting.png',
            title: '분갈이',
            field: PlantField.repotting,
          ),
          SizedBox(
            height: 12.h,
          ),
          const AlarmBox(
            iconPath: 'assets/images/management/nutrient.png',
            title: '영양제',
            field: PlantField.nutrient,
          ),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }
}
