import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/my_page/provider/user_me_provider.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userMeProvider);
    print(userState);
    return const DefaultLayout(
        title: '마이페이지',
        child: Column(
          children: [],
        ));
  }
}
