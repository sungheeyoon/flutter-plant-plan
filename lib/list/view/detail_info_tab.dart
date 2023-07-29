import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/add/view/add_second_screen.dart';
import 'package:plant_plan/common/model/user_info_model.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/list/wideget/infoTipButton.dart';
import 'package:plant_plan/utils/colors.dart';

class DetailInfoTab extends StatefulWidget {
  const DetailInfoTab({super.key});

  @override
  State<DetailInfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<DetailInfoTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 24.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: const UpcomingAlarm(),
        ),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: const SettingAlarm(),
        ),
        SizedBox(
          height: 40.h,
        ),
        const TipsWidget(),
        SizedBox(
          height: 80.h,
        )
      ],
    );
  }
}

class SettingAlarm extends StatelessWidget {
  const SettingAlarm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          isDetail: true,
        ),
        SizedBox(
          height: 12.h,
        ),
        const AlarmBox(
          iconPath: 'assets/images/management/repotting.png',
          title: '분갈이',
          field: PlantField.repotting,
          isDetail: true,
        ),
        SizedBox(
          height: 12.h,
        ),
        const AlarmBox(
          iconPath: 'assets/images/management/nutrient.png',
          title: '영양제',
          field: PlantField.nutrient,
          isDetail: true,
        ),
      ],
    );
  }
}

class UpcomingAlarm extends ConsumerWidget {
  const UpcomingAlarm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserInfoModel? userInfo = ref.watch(detailProvider);
    String watering = "";
    String repotting = "";
    String nutrient = "";
    List<Alarm> alarms = [];
    if (userInfo != null) {
      DateTime today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      alarms = userInfo.info.alarms;
      for (final alarm in alarms) {
        DateTime alarmDay = DateTime(
          alarm.startTime.year,
          alarm.startTime.month,
          alarm.startTime.day,
        );
        while (alarm.repeat > 0 && alarmDay.isBefore(today)) {
          alarmDay = alarmDay.add(Duration(days: alarm.repeat));
        }

        int difference = today.difference(alarmDay).inDays.abs();
        if (alarm.field == PlantField.watering) {
          watering = difference == 0 ? 'TODAY' : 'D-$difference';
        } else if (alarm.field == PlantField.repotting) {
          repotting = difference == 0 ? 'TODAY' : 'D-$difference';
        } else if (alarm.field == PlantField.nutrient) {
          nutrient = difference == 0 ? 'TODAY' : 'D-$difference';
        }
      }
    }

    return Column(
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
              width: 98.w,
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
                    "물주기",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: const Color(0xFF72CBE7),
                        ),
                  ),
                  Text(
                    watering == "" ? '알림 없음' : watering,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: watering == "" ? grayColor400 : grayBlack,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 98.w,
              height: 110.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.h),
                border: Border.all(
                  color: subColor2,
                  width: 1.h,
                ),
              ),
              padding: EdgeInsets.all(16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/management/repotting.png',
                    width: 28.h,
                    height: 28.h,
                  ),
                  Text(
                    "분갈이",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: subColor2,
                        ),
                  ),
                  Text(
                    repotting == "" ? '알림 없음' : repotting,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: repotting == "" ? grayColor400 : grayBlack,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 98.w,
              height: 110.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.h),
                border: Border.all(
                  color: keyColor500,
                  width: 1.h,
                ),
              ),
              padding: EdgeInsets.all(16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/management/nutrient.png',
                    width: 28.h,
                    height: 28.h,
                  ),
                  Text(
                    "영양제",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: keyColor500,
                        ),
                  ),
                  Text(
                    nutrient == "" ? '알림 없음' : nutrient,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: nutrient == "" ? grayColor400 : grayBlack,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class TipsWidget extends StatefulWidget {
  const TipsWidget({
    super.key,
  });

  @override
  State<TipsWidget> createState() => _TipsWidgetState();
}

class _TipsWidgetState extends State<TipsWidget> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.h),
          child: Text(
            "성장 TIP",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: primaryColor),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DetailTipButton(
                  text: "물주기",
                  isFocused: _selectedIndex == 0,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
                SizedBox(width: 8.h),
                DetailTipButton(
                  text: "햇빛",
                  isFocused: _selectedIndex == 1,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
                SizedBox(width: 8.h),
                DetailTipButton(
                  text: "온도",
                  isFocused: _selectedIndex == 2,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),
                SizedBox(width: 8.h),
                DetailTipButton(
                  text: "습도",
                  isFocused: _selectedIndex == 3,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                ),
                SizedBox(width: 8.h),
                DetailTipButton(
                  text: "흙",
                  isFocused: _selectedIndex == 4,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                ),
                SizedBox(width: 8.h),
                DetailTipButton(
                  text: "분갈이",
                  isFocused: _selectedIndex == 5,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 5;
                    });
                  },
                ),
                SizedBox(width: 8.h),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Container(
            padding: EdgeInsets.all(20.h),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: grayColor100,
              borderRadius: BorderRadius.all(Radius.circular(12.h)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "흙이 바싹 마르지 않게",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: grayBlack),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "빠르게 성장하는 봄~가을에는 보통 주 1~2회 겉흙이 말랐을 때에 충분히 관수를 해주세요. 안시리움은 습한 환경을 좋아하는 특성을 가지고 있기 때문에 중간중간 잎에 분무를 해주어 습도를 올려주면 좋아요. 물을 준 뒤 통풍이 잘 되는 곳에서 관리해 주세요. 통풍이 안되는 곳에서 잎에 분무를 하게 되면 검은 점이 생길 수 있으니 조심하세요. 여름 장마철과 겨울에는 성장속도가 느려지기 때문에 물 주는 주기를 늘려 2주에 1번씩 주는 것이 좋아요.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: grayBlack),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
