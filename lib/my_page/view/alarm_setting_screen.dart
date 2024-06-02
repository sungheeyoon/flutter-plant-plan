import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/model/plants_model.dart';
import 'package:plant_plan/common/provider/alarm_setting_provider.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/services/local_notification_service.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmSettingScreen extends ConsumerStatefulWidget {
  const AlarmSettingScreen({super.key});

  @override
  ConsumerState<AlarmSettingScreen> createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends ConsumerState<AlarmSettingScreen> {
  late bool serviceSwitch;
  late bool wateringSwitch;
  late bool repottingSwitch;
  late bool nutrientSwitch;
  late bool noticeSwitch;
  bool notificationStatus = false;
  bool systemSwitch = false;

  LocalNotificationService notificationService = LocalNotificationService();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    bool permissionStatus = await checkNotificationGranted();
    setState(() {
      notificationStatus = permissionStatus;
    });
    setSwitch();
    //for notification print
    // await printPendingNotifications();
  }

  Future<bool> checkNotificationGranted() async {
    PermissionStatus status = await Permission.notification.status;

    if (status != PermissionStatus.granted) {
      return false;
    } else {
      return true;
    }
  }

  void onSwitchValueChanged() {
    setState(() {
      serviceSwitch =
          wateringSwitch || repottingSwitch || nutrientSwitch || noticeSwitch;
    });
  }

  void setSwitch() {
    wateringSwitch = ref.read(wateringProvider);
    repottingSwitch = ref.read(repottingProvider);
    nutrientSwitch = ref.read(nutrientProvider);
    noticeSwitch = ref.read(noticeProvider);
    onSwitchValueChanged();
  }

  // Future<void> printPendingNotifications() async {
  //   List<PendingNotificationRequest> notifications =
  //       await notificationService.retrievePendingNotifications();
  //   for (var notification in notifications) {
  //     print('Notification ID: ${notification.id}');
  //     print('Notification Title: ${notification.title}');
  //     print('Notification Body: ${notification.body}');
  //     print('Notification Payload: ${notification.payload}');
  //     print('--------------------------------------------------');

  //   }
  // }

  Future<void> setSwitchValue(key, value) async {
    final PlantsModel plantsState = ref.read(plantsProvider) as PlantsModel;
    final List<PlantModel> plants = plantsState.data;
    LocalNotificationService notificationService = LocalNotificationService();
    bool watering = false;
    bool repotting = false;
    bool nutrient = false;

    switch (key) {
      case 'watering':
        ref.read(wateringProvider.notifier).state = value;
        if (value) {
          watering = true;
          for (final plant in plants) {
            await notificationService.scheduleAlarmNotifications(
              plant: plant,
              watering: watering,
              repotting: repotting,
              nutrient: nutrient,
            );
          }
        } else {
          await notificationService.deleteFromField(PlantField.watering);
        }
        break;
      case 'repotting':
        ref.read(repottingProvider.notifier).state = value;
        if (value) {
          repotting = true;
          for (final plant in plants) {
            await notificationService.scheduleAlarmNotifications(
              plant: plant,
              watering: watering,
              repotting: repotting,
              nutrient: nutrient,
            );
          }
        } else {
          await notificationService.deleteFromField(PlantField.repotting);
        }
        break;
      case 'nutrient':
        ref.read(nutrientProvider.notifier).state = value;
        if (value) {
          nutrient = true;
          for (final plant in plants) {
            await notificationService.scheduleAlarmNotifications(
              plant: plant,
              watering: watering,
              repotting: repotting,
              nutrient: nutrient,
            );
          }
        } else {
          await notificationService.deleteFromField(PlantField.nutrient);
        }
        break;
      case 'notice':
        ref.read(noticeProvider.notifier).state = value;
        break;
      default:
        return;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    wateringSwitch = ref.watch(wateringProvider);
    repottingSwitch = ref.watch(repottingProvider);
    nutrientSwitch = ref.watch(nutrientProvider);
    noticeSwitch = ref.watch(noticeProvider);
    serviceSwitch =
        wateringSwitch || repottingSwitch || nutrientSwitch || noticeSwitch;

    return DefaultLayout(
      title: '알림 설정',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: !notificationStatus
            ? Column(
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: grayBlack,
                                ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '푸시를 받으려면 알림 허용이 필요해요',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: grayColor500,
                                    ),
                          ),
                        ],
                      ),
                      CupertinoSwitch(
                        value: systemSwitch,
                        onChanged: (value) async {
                          setState(() {
                            systemSwitch = value;
                          });

                          bool settingsOpened = await openAppSettings();
                          if (settingsOpened) {
                            BasicMessageChannel<String?> lifecycleChannel =
                                SystemChannels.lifecycle;
                            lifecycleChannel
                                .setMessageHandler((String? msg) async {
                              if (msg!.contains("resumed")) {
                                //? 시스템 알림설정 종료했을때(< 뒤로가기 시)
                                PermissionStatus changedStatus =
                                    await Permission.notification.status;
                                print('changedStatus:$changedStatus');
                                if (changedStatus == PermissionStatus.granted) {
                                  //!notification on - 알림설정함
                                  setState(() {
                                    notificationStatus = true;
                                  });
                                } else {
                                  // notification off -알림설정 안함
                                  setState(() {
                                    notificationStatus = false;
                                    setState(() {
                                      systemSwitch = false;
                                    });
                                  });
                                }
                              }
                              return '';
                            });
                          }
                        },
                        trackColor: grayColor400,
                        activeColor: pointColor2,
                      ),
                    ],
                  ),
                ],
              )
            : Column(
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: grayBlack,
                                ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '푸시를 받으려면 알림 허용이 필요해요',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
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
                            setSwitchValue('watering', value);
                            setSwitchValue('repotting', value);
                            setSwitchValue('nutrient', value);
                            setSwitchValue('notice', value);
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grayColor600,
                                  ),
                        ),
                        CupertinoSwitch(
                          value: wateringSwitch,
                          onChanged: (value) {
                            setState(() {
                              setSwitchValue('watering', value);
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grayColor600,
                                  ),
                        ),
                        CupertinoSwitch(
                          value: repottingSwitch,
                          onChanged: (value) {
                            setState(() {
                              setSwitchValue('repotting', value);
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grayColor600,
                                  ),
                        ),
                        CupertinoSwitch(
                          value: nutrientSwitch,
                          onChanged: (value) {
                            setState(() {
                              setSwitchValue('nutrient', value);
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grayColor600,
                                  ),
                        ),
                        CupertinoSwitch(
                          value: noticeSwitch,
                          onChanged: (value) {
                            setState(() {
                              setSwitchValue('notice', value);
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
