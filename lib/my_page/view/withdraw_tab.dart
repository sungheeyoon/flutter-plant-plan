// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:plant_plan/common/layout/default_layout.dart';
// import 'package:plant_plan/my_page/view/withdraw_first_screen.dart';
// import 'package:plant_plan/my_page/view/withdraw_last_screen.dart';

// class WithdrawTab extends StatefulWidget {
//   static String get routeName => 'home';

//   const WithdrawTab({super.key});

//   @override
//   State<WithdrawTab> createState() => _WithdrawTabState();
// }

// class _WithdrawTabState extends State<WithdrawTab>
//     with SingleTickerProviderStateMixin {
//   late TabController controller;

//   int index = 0;

//   @override
//   void initState() {
//     super.initState();

//     controller = TabController(length: 2, vsync: this);

//     controller.addListener(tabListener);
//   }

//   @override
//   void dispose() {
//     controller.removeListener(tabListener);

//     super.dispose();
//   }

//   void tabListener() {
//     setState(() {
//       index = controller.index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultLayout(
//       title: '회원 탈퇴',
//       floatingActionButton: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//         width: 360.w,
//         child: FloatingActionButton.extended(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           elevation: 0,
//           onPressed: () {
//             // Navigator.push(context, MaterialPageRoute(builder: (context) => YourScreen()));
//           },
//           // backgroundColor: (reasonController.text.isEmpty ||
//           //             reasonController.text == '기타') &&
//           //         messageController.text.isEmpty
//           //     ? grayColor300
//           //     : errorColor,
//           label: Text(
//             "탈퇴하기",
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   color: Colors.white,
//                 ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       child: TabBarView(
//         physics: const NeverScrollableScrollPhysics(),
//         controller: controller,
//         children: const [
//           WithdrawFirstScreen(),
//           WithdrawLastScreen(),
//         ],
//       ),
//     );
//   }
// }
