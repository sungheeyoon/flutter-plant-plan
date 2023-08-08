// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:plant_plan/add/model/alarm_model.dart';
// import 'package:plant_plan/add/model/plant_model.dart';
// import 'package:plant_plan/add/provider/photo_provider.dart';
// import 'package:plant_plan/add/provider/add_plant_provider.dart';
// import 'package:plant_plan/add/view/add_first_screen.dart';
// import 'package:plant_plan/add/view/add_third_screen.dart';
// import 'package:plant_plan/add/view/alarm_screen.dart';
// import 'package:plant_plan/add/widget/progress_bar.dart';
// import 'package:plant_plan/common/layout/default_layout.dart';
// import 'package:plant_plan/list/provider/detail_provider.dart';
// import 'package:plant_plan/utils/colors.dart';
// import 'package:plant_plan/common/widget/rounded_button.dart';

// class AddSecondScreen extends ConsumerWidget {
//   static String get routeName => 'addSecond';
//   const AddSecondScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final PlantModel plantState = ref.watch(addPlantProvider);
//     final File? photoState = ref.watch(photoProvider);

//     return DefaultLayout(
//       title: '식물추가',
//       floatingActionButton: RoundedButton(
//         font: Theme.of(context).textTheme.bodyLarge,
//         backgroundColor:
//             plantState.information.id != "" ? pointColor2 : grayColor300,
//         borderColor: plantState.information.id != ""
//             ? pointColor2.withOpacity(
//                 0.5,
//               )
//             : grayColor300,
//         width: 328.w,
//         height: 44.h,
//         textColor: Colors.white,
//         name: '다음',
//         onPressed: () async {
//           if (plantState.information.id != "") {
//             Navigator.pushNamed(context, AddThirdScreen.routeName);
//           }
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 24.0,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 8.0,
//               ),
//               const ProgressBar(pageIndex: 1),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Center(
//                 child: Container(
//                   width: 360.w,
//                   padding: EdgeInsets.all(16.h),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16.h),
//                     boxShadow: [
//                       BoxShadow(
//                         color: grayBlack.withOpacity(0.1),
//                         blurRadius: 8,
//                         offset: const Offset(2, 2), // Shadow position
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           if (photoState != null) //찍음
//                             Stack(children: [
//                               FittedBox(
//                                 fit: BoxFit.contain,
//                                 child: CircleAvatar(
//                                   radius: 18.h, // Image radius
//                                   backgroundImage: FileImage(photoState),
//                                 ),
//                               ),
//                             ])
//                           else if (plantState.information.imageUrl != "") //안찍음
//                             FittedBox(
//                               fit: BoxFit.contain,
//                               child: CircleAvatar(
//                                 radius: 18.h, // Image radius
//                                 backgroundImage: NetworkImage(
//                                     plantState.information.imageUrl),
//                               ),
//                             )
//                           else
//                             Image(
//                               image: const AssetImage('assets/images/pot.png'),
//                               width: 36.h,
//                               height: 36.h,
//                             ),
//                           SizedBox(
//                             width: 12.h,
//                           ),
//                           if (plantState.information.name != "")
//                             Text(
//                               plantState.information.name,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium!
//                                   .copyWith(
//                                     color: grayBlack,
//                                   ),
//                             ),
//                         ],
//                       ),
//                       RoundedButton(
//                         font: Theme.of(context).textTheme.labelMedium!.copyWith(
//                               fontSize: 13.sp,
//                             ),
//                         backgroundColor: Colors.white,
//                         borderColor: pointColor2.withOpacity(
//                           0.5,
//                         ),
//                         width: 63.h,
//                         height: 30.h,
//                         textColor: pointColor2,
//                         name: '변경',
//                         onPressed: () => Navigator.pushNamed(
//                             context, AddFirstScreen.routeName),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 40.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.timer_outlined, // 플러스 아이콘
//                     size: 32.h, // 아이콘 크기 설정
//                     color: pointColor2, // 아이콘 색상 설정
//                   ),
//                   SizedBox(
//                     width: 8.h,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '식물 상태에 따라 관리 주기를',
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                               color: pointColor2,
//                             ),
//                       ),
//                       SizedBox(
//                         height: 4.h,
//                       ),
//                       Text(
//                         '원하는대로 설정하고 알림을 받아보세요',
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                               color: pointColor2,
//                             ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 12.h,
//               ),
//               const AlarmBox(
//                 field: PlantField.watering,
//                 isDetail: false,
//               ),
//               SizedBox(
//                 height: 12.h,
//               ),
//               const AlarmBox(
//                 field: PlantField.repotting,
//                 isDetail: false,
//               ),
//               SizedBox(
//                 height: 12.h,
//               ),
//               const AlarmBox(
//                 field: PlantField.nutrient,
//                 isDetail: false,
//               ),
//               SizedBox(
//                 height: 12.h,
//               ),
//               Text(
//                 '앱 알림 권한을 허용해야 정상적인 알림 서비스를 이용하실 수 있어요',
//                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                       color: grayColor500,
//                     ),
//               ),
//               SizedBox(
//                 height: 128.h,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


