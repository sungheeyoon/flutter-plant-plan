import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/widget/alarm_box_widget.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/list/wideget/tipButton_widget.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final String id;
  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PlantModel? detailData = ref.watch(detailProvider);
    return DefaultLayout(
      title: '내 식물',
      child: SingleChildScrollView(
        child: detailData is PlantModel
            ? Column(
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: const DetailCard(),
                  ),
                  SizedBox(
                    height: 40.h,
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
                  const Tips(),
                  SizedBox(
                    height: 80.h,
                  )
                ],
              )
            : const Center(
                child: (Text(
                  '데이터를 불러오는데 실패했습니다.',
                )),
              ),
      ),
    );
  }
}

class DetailCard extends ConsumerStatefulWidget {
  const DetailCard({
    super.key,
  });

  @override
  ConsumerState<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends ConsumerState<DetailCard> {
  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {
    final PlantModel? data = ref.watch(detailProvider);
    return Container(
      width: 360.w,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.h,
      ),
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
              Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.h),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      data != null && data.userImageUrl == ""
                          ? data.information.imageUrl
                          : data?.userImageUrl ?? "",
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data?.alias != "")
                    Text(
                      data!.alias,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: keyColor700,
                          ),
                    ),
                  //font height check
                  if (data?.alias != "")
                    const SizedBox(
                      height: 0,
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data!.information.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: grayBlack,
                            ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorited = !isFavorited;
                          });
                        },
                        child: Image(
                          image: AssetImage(
                            isFavorited
                                ? 'assets/icons/fav/fav_active.png'
                                : 'assets/icons/fav/fav_inactive.png',
                          ),
                          width: 20.h,
                          height: 20.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Image(
              image: const AssetImage('assets/icons/edit.png'),
              width: 24.h,
              height: 24.h,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailCardModal extends StatelessWidget {
  const DetailCardModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 312,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 8),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // 모달 창 크기를 컨텐츠에 맞게 조절
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Modal Title",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Your Content Here"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Perform an action
                },
                child: const Text("Confirm"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingAlarm extends ConsumerWidget {
  const UpcomingAlarm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlantModel? detailState = ref.watch(detailProvider);
    String watering = "";
    String repotting = "";
    String nutrient = "";
    List<AlarmModel> alarms = [];
    if (detailState != null) {
      DateTime today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      alarms = detailState.alarms;
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
        const AlarmBoxWidget(
          field: PlantField.watering,
          isDetail: true,
        ),
        SizedBox(
          height: 12.h,
        ),
        const AlarmBoxWidget(
          field: PlantField.repotting,
          isDetail: true,
        ),
        SizedBox(
          height: 12.h,
        ),
        const AlarmBoxWidget(
          field: PlantField.nutrient,
          isDetail: true,
        ),
      ],
    );
  }
}

class Tips extends StatefulWidget {
  const Tips({
    super.key,
  });

  @override
  State<Tips> createState() => _Tips();
}

class _Tips extends State<Tips> {
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 24.h),
              TipButtonWidget(
                text: "물주기",
                isFocused: _selectedIndex == 0,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "햇빛",
                isFocused: _selectedIndex == 1,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "온도",
                isFocused: _selectedIndex == 2,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "습도",
                isFocused: _selectedIndex == 3,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "흙",
                isFocused: _selectedIndex == 4,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "분갈이",
                isFocused: _selectedIndex == 5,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 5;
                  });
                },
              ),
              SizedBox(width: 24.h),
            ],
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
