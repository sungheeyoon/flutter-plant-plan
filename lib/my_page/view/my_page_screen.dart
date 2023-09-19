import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/root_tab.dart';
import 'package:plant_plan/list/model/list_card_model.dart';
import 'package:plant_plan/list/wideget/plant_list_card.dart';
import 'package:plant_plan/my_page/model/user_model.dart';
import 'package:plant_plan/my_page/provider/user_me_provider.dart';
import 'package:plant_plan/my_page/view/account_screen.dart';
import 'package:plant_plan/my_page/view/alarm_setting_screen.dart';
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
    final userMeState = ref.watch(userMeProvider) as UserModel;
    List<ListCardModel> cardList = getCardList(plants, true);

    return DefaultLayout(
      title: '마이페이지',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: UsernameAndAlarm(username: userMeState.username),
          ),
          const SizedBox(
            height: 21,
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
                const Icon(
                  Icons.navigate_next_sharp,
                  color: grayColor500,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
        const ImageIcon(
          AssetImage('assets/icons/my_page/bell.png'),
          color: primaryColor,
          size: 28,
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
          16,
        ),
        border: Border.all(color: grayColor200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccountScreen(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ImageIcon(
                    AssetImage('assets/icons/my_page/setting.png'),
                    color: grayColor700,
                    size: 24,
                  ),
                  const SizedBox(
                    height: 6,
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
          Container(
            width: 2.0,
            height: 16,
            color: grayColor300,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AlarmSettingScreen(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ImageIcon(
                    AssetImage('assets/icons/my_page/alarm.png'),
                    color: grayColor700,
                    size: 24,
                  ),
                  const SizedBox(
                    height: 6,
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
          Container(
            width: 2.0,
            height: 16,
            color: grayColor300,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ImageIcon(
                  AssetImage('assets/icons/my_page/megaphone.png'),
                  color: grayColor700,
                  size: 24,
                ),
                const SizedBox(
                  height: 6,
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
        ],
      ),
    );
  }
}

class Favorite extends StatelessWidget {
  const Favorite({
    super.key,
    required this.cardList,
    required this.plants,
  });

  final List<ListCardModel> cardList;
  final List<PlantModel> plants;

  @override
  Widget build(BuildContext context) {
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
                    const Icon(
                      Icons.navigate_next_sharp,
                      color: grayColor500,
                      size: 20,
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
                      PlantListCard(cardData: cardList[index]),
                      if (cardList.length - 1 != index)
                        const SizedBox(
                          width: 8,
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
