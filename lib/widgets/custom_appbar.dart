// import 'package:flutter/material.dart';
// import 'package:plant_plan/utils/colors.dart';
// import 'package:plant_plan/widgets/snapping_above.dart';

// class CustomAppBar extends StatelessWidget {
//   final String title;
//   final bool home;
//   final Color bgColor;
//   const CustomAppBar(
//       {Key? key,
//       required this.title,
//       required this.home,
//       this.bgColor = primaryColor})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final fullHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: AppBar(
//         toolbarHeight: fullHeight * 0.1,
//         iconTheme: const IconThemeData(
//           color: primaryColor, //색변경
//         ),
//         leading: IconButton(
//             onPressed: () {
//               if (home) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SnappingAbove(),
//                     ));
//               } else {
//                 Navigator.of(context).pop();
//               }
//             },
//             icon: const Icon(Icons.arrow_back_ios_new_rounded)),
//         elevation: 0,
//         backgroundColor: bgColor,
//         title: Text(title,
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineLarge!
//                 .copyWith(color: primaryColor)),
//         centerTitle: true,
//       ),
//     );
//   }
// }
