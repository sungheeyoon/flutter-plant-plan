import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/utils/colors.dart';

class AlarmSettingScreen extends StatefulWidget {
  const AlarmSettingScreen({super.key});

  @override
  State<AlarmSettingScreen> createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends State<AlarmSettingScreen> {
  bool serviceSwitch = false;
  bool waterringSwitch = false;
  bool repottingSwitch = false;
  bool nutrientSwitch = false;
  bool noticeSwitch = false;

  @override
  void initState() {
    super.initState();
  }

  // 각 스위치의 상태가 변경될 때 호출되는 콜백 함수
  void onSwitchValueChanged() {
    setState(() {
      serviceSwitch =
          waterringSwitch || repottingSwitch || nutrientSwitch || noticeSwitch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '알림 설정',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '서비스 알림',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: grayBlack,
                              ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '푸시를 받으려면 알림 허용이 필요해요',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grayColor500,
                          ),
                    ),
                  ],
                ),
                CupertinoSwitch(
                  value: serviceSwitch,
                  onChanged: (value) {
                    setState(() {
                      serviceSwitch = value;
                      waterringSwitch = value;
                      repottingSwitch = value;
                      nutrientSwitch = value;
                      noticeSwitch = value;
                    });
                  },
                  trackColor: grayColor400,
                  activeColor: pointColor2,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: const BoxDecoration(
                color: grayColor200,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Text(
                '식물 관리 정보',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: grayColor700,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '물주기',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grayColor600,
                        ),
                  ),
                  CupertinoSwitch(
                    value: waterringSwitch,
                    onChanged: (value) {
                      setState(() {
                        waterringSwitch = value;
                        onSwitchValueChanged();
                      });
                    },
                    trackColor: grayColor400,
                    activeColor: pointColor2,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: grayColor300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '분갈이',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grayColor600,
                        ),
                  ),
                  CupertinoSwitch(
                    value: repottingSwitch,
                    onChanged: (value) {
                      setState(() {
                        repottingSwitch = value;
                        onSwitchValueChanged();
                      });
                    },
                    trackColor: grayColor400,
                    activeColor: pointColor2,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: grayColor300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '영양제',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grayColor600,
                        ),
                  ),
                  CupertinoSwitch(
                    value: nutrientSwitch,
                    onChanged: (value) {
                      setState(() {
                        nutrientSwitch = value;
                        onSwitchValueChanged();
                      });
                    },
                    trackColor: grayColor400,
                    activeColor: pointColor2,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: const BoxDecoration(
                color: grayColor200,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Text(
                '이용 알림',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: grayColor700,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '공지사항',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grayColor600,
                        ),
                  ),
                  CupertinoSwitch(
                    value: noticeSwitch,
                    onChanged: (value) {
                      setState(() {
                        noticeSwitch = value;
                        onSwitchValueChanged();
                      });
                    },
                    trackColor: grayColor400,
                    activeColor: pointColor2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
