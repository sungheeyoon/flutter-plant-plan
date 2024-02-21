import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/view/root_tab.dart';
import 'package:plant_plan/list/model/list_card_model.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/list/view/detail_screen.dart';
import 'package:plant_plan/list/wideget/plant_list_card.dart';
import 'package:plant_plan/my_page/model/user_model.dart';
import 'package:plant_plan/my_page/provider/user_me_provider.dart';
import 'package:plant_plan/my_page/view/account_screen.dart';
import 'package:plant_plan/my_page/view/alarm_setting_screen.dart';
import 'package:plant_plan/my_page/view/announcement_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/list_utils.dart';

class MyPageScreen extends ConsumerWidget {
  final List<PlantModel> plants;
  const MyPageScreen({
    super.key,
    required this.plants,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userMeState = ref.watch(userMeProvider);
    List<ListCardModel> cardList = getCardList(plants, true);
    if (userMeState is UserModel) {
      return DefaultLayout(
        title: '마이페이지',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 9.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: UsernameAndAlarm(username: userMeState.username),
            ),
            SizedBox(
              height: 21.h,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SettingMenu(),
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(
              color: grayColor100,
              thickness: 8,
            ),
            const SizedBox(
              height: 12,
            ),
            Favorite(
              cardList: cardList,
              plants: plants,
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '저장된 다이어리',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: grayBlack,
                        ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      final rootTabState =
                          context.findAncestorStateOfType<RootTabState>();
                      if (rootTabState != null) {
                        rootTabState.navigateToBookMarkDiaryScreen();
                      }
                    },
                    child: Icon(
                      Icons.navigate_next_sharp,
                      color: grayColor500,
                      size: 20.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

class UsernameAndAlarm extends StatelessWidget {
  final String username;
  const UsernameAndAlarm({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$username님',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: grayBlack,
              ),
        ),
      ],
    );
  }
}

class SettingMenu extends StatelessWidget {
  const SettingMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16.w,
        ),
        border: Border.all(color: grayColor200, width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountScreen(),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 28.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage('assets/icons/my_page/setting.png'),
                      color: grayColor700,
                      size: 24.w,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      '계정 정보',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: grayColor700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 2.0.w,
            height: 16.w,
            color: grayColor200,
          ),
          Flexible(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AlarmSettingScreen(),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 28.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage('assets/icons/my_page/alarm.png'),
                      color: grayColor700,
                      size: 24.w,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      '알림 설정',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: grayColor700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 2.0.w,
            height: 16.w,
            color: grayColor200,
          ),
          Flexible(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnnouncementScreen(),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 28.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage('assets/icons/my_page/megaphone.png'),
                      color: grayColor700,
                      size: 24.w,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      '공지사항',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: grayColor700),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Favorite extends ConsumerWidget {
  const Favorite({
    super.key,
    required this.cardList,
    required this.plants,
  });

  final List<ListCardModel> cardList;
  final List<PlantModel> plants;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '즐겨찾는 식물',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: grayBlack,
                    ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  final rootTabState =
                      context.findAncestorStateOfType<RootTabState>();
                  if (rootTabState != null) {
                    rootTabState.navigateToFavoriteListScreen();
                  }
                },
                child: Row(
                  children: [
                    Text(
                      '${cardList.length}개',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: grayColor500,
                          ),
                    ),
                    Icon(
                      Icons.navigate_next_sharp,
                      color: grayColor500,
                      size: 20.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const SizedBox(width: 24),
                for (int index = 0; index < cardList.length; index++)
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () async {
                            final plant = await ref
                                .watch(plantsProvider.notifier)
                                .getPlant(cardList[index].docId);

                            ref
                                .read(detailProvider.notifier)
                                .updateDetail(plant);
                            if (!context.mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailScreen(),
                              ),
                            );
                          },
                          child: PlantListCard(cardData: cardList[index])),
                      if (cardList.length - 1 != index)
                        SizedBox(
                          width: 8.w,
                        )
                    ],
                  ),
                const SizedBox(width: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
