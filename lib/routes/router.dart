import 'package:go_router/go_router.dart';
import 'package:plant_plan/add/view/add_first_screen.dart';
import 'package:plant_plan/add/view/add_second_screen.dart';
import 'package:plant_plan/add/view/add_tab.dart';
import 'package:plant_plan/add/view/add_third_screen.dart';
import 'package:plant_plan/add/view/alarm_screen.dart';
import 'package:plant_plan/add/view/search_screen.dart';
import 'package:plant_plan/common/view/home_screen.dart';

// GoRouter configuration
List<GoRoute> routes = [
  GoRoute(
    path: '/',
    name: 'home',
    builder: (context, state) => const HomeScreen(),
    routes: [
      GoRoute(
        path: 'add',
        name: 'add',
        builder: (context, state) => const AddTab(),
        routes: [
          GoRoute(
            path: 'first',
            name: 'first',
            builder: (context, state) => const AddFirstScreen(),
            routes: [
              GoRoute(
                path: 'search',
                name: 'search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'second',
            name: 'second',
            builder: (context, state) => const AddSecondScreen(),
            routes: [
              GoRoute(
                path: 'alarm',
                name: 'alarm',
                builder: (context, state) => AlarmScreen(
                  title: 'My Alarm',
                  field: myPlantField,
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'third',
            name: 'third',
            builder: (context, state) => const AddThirdScreen(),
          ),
        ],
      ),
    ],
  ),
];
