// import 'package:flutter/material.dart';
// import 'package:plant_plan/widgets/clear_card.dart';

// class Management extends StatelessWidget {
//   const Management({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 60,
//               ),
//               Text(
//                 "곧 다가오는 내 식물 관리",
//                 style: Theme.of(context)
//                     .textTheme
//                     .headlineLarge!
//                     .copyWith(color: const Color.fromRGBO(29, 49, 91, 1)),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               const ClearCard(
//                   imageUri: 'assets/images/management/nutrient_outline.png',
//                   title: '인도고무나무',
//                   action: '물 주기',
//                   day: '8.15(일)',
//                   time: '13:00',
//                   dayBool: true,
//                   clear: true),
//               const SizedBox(
//                 height: 12,
//               ),
//               const ClearCard(
//                   imageUri: 'assets/images/management/nutrient_outline.png',
//                   title: '인도고무나무',
//                   action: '물 주기',
//                   day: '8.15(일)',
//                   time: '13:00',
//                   dayBool: false,
//                   clear: false),
//               const SizedBox(
//                 height: 12,
//               ),
//               const ClearCard(
//                   imageUri: 'assets/images/management/nutrient_outline.png',
//                   title: '인도고무나무',
//                   action: '물 주기',
//                   day: '8.15(일)',
//                   time: '13:00',
//                   dayBool: false,
//                   clear: true),
//               const SizedBox(
//                 height: 12,
//               ),
//               const ClearCard(
//                   imageUri: 'assets/images/management/nutrient_outline.png',
//                   title: '인도고무나무',
//                   action: '물 주기',
//                   day: '8.15(일)',
//                   time: '13:00',
//                   dayBool: true,
//                   clear: false),
//               const SizedBox(
//                 height: 32,
//               ),
//               Center(
//                 child: SizedBox(
//                   width: 200,
//                   height: 40,
//                   child: OutlinedButton(
//                       onPressed: () {},
//                       style: OutlinedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         side: const BorderSide(
//                             width: 0, color: Color.fromRGBO(192, 220, 185, 1)),
//                         backgroundColor: const Color.fromRGBO(192, 220, 185, 1),
//                       ),
//                       child: Text(
//                         "전체보기",
//                         style: Theme.of(context)
//                             .textTheme
//                             .labelLarge!
//                             .copyWith(color: Colors.white),
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
