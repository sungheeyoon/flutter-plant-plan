// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:plant_plan/add/provider/plant_provider.dart';

// import 'package:plant_plan/add/view/add_first_screen.dart';
// import 'package:plant_plan/add/view/add_second_screen.dart';
// import 'package:plant_plan/add/view/add_third_screen.dart';
// import 'package:plant_plan/common/layout/default_layout.dart';
// import 'package:plant_plan/common/widget/rounded_button.dart';
// import 'package:plant_plan/utils/colors.dart';

// class AddTab extends ConsumerStatefulWidget {
//   static String get routeName => 'add';

//   const AddTab({
//     Key? key,
//   }) : super(key: key);
//   @override
//   ConsumerState<AddTab> createState() => _AddTabState();
// }

// class _AddTabState extends ConsumerState<AddTab>
//     with SingleTickerProviderStateMixin {
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentPageIndex = 0;

//   // Future uploadFile() async {
//   //   String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

//   //   Reference referenceRoot = FirebaseStorage.instance.ref();
//   //   Reference referenceDirImages = referenceRoot.child('images');

//   //   Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

//   //   try {
//   //     setState(() {
//   //       uploadTask = referenceImageToUpload.putFile(File(pickedFile!.path));
//   //     });
//   //   } catch (error) {
//   //     print(error);
//   //   }
//   //   final snapshot = await uploadTask!.whenComplete(() => {});

//   //   final urlDownload = await snapshot.ref.getDownloadURL();

//   //   setState(() {
//   //     uploadTask = null;
//   //   });
//   // }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selectedPlant = ref.watch(selectedPlantProvider);
//     return DefaultLayout(
//       title: '식물추가',
//       floatingActionButton: RoundedButton(
//         font: Theme.of(context).textTheme.bodyLarge,
//         backgroundColor: selectedPlant != null ? pointColor2 : grayColor300,
//         borderColor: selectedPlant != null
//             ? pointColor2.withOpacity(
//                 0.5,
//               )
//             : grayColor300,
//         width: 328.w,
//         height: 44.h,
//         textColor: Colors.white,
//         name: _currentPageIndex == 2 ? '식물 추가 완료' : '다음',
//         onPressed: () async {
//           if (selectedPlant != null) {
//             if (_pageController.page == 0) {
//               _pageController.jumpToPage(1);
//               _currentPageIndex = 1;
//             } else if (_pageController.page == 1) {
//               _pageController.jumpToPage(2);
//               _currentPageIndex = 2;
//             }
//           }
//           setState(() {});
//         },
        
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       child: PageView(
//         controller: _pageController,
//         children: const [
//           AddFirstScreen(),
//           AddSecondScreen(),
//           AddThirdScreen(),
//         ],
//       ),
//     );
//   }

//   // Future<dynamic> toNextDialog(BuildContext context) {
//   //   return showDialog(
//   //     context: context,
//   //     builder: (ctx) => Dialog(
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.circular(10.0),
//   //       ),
//   //       child: Column(
//   //         mainAxisSize: MainAxisSize.min,
//   //         children: [
//   //           const SizedBox(
//   //             height: 32,
//   //           ),
//   //           Text('관리 날짜를 지정하지 않은 경우',
//   //               style: Theme.of(context)
//   //                   .textTheme
//   //                   .bodyMedium!
//   //                   .copyWith(color: grayBlack)),
//   //           Text('현재 식물을 추가한 날짜를 기준으로 적용됩니다',
//   //               style: Theme.of(context)
//   //                   .textTheme
//   //                   .bodyMedium!
//   //                   .copyWith(color: grayBlack)),
//   //           const SizedBox(
//   //             height: 32,
//   //           ),
//   //           Container(
//   //             decoration: BoxDecoration(
//   //               border: Border.all(
//   //                 width: 1,
//   //                 color: grayColor200,
//   //               ),
//   //             ),
//   //           ),
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //             children: [
//   //               TextButton(
//   //                 onPressed: () {
//   //                   Navigator.of(context).pop();
//   //                 },
//   //                 style: TextButton.styleFrom(
//   //                     padding: const EdgeInsets.symmetric(vertical: 16)),
//   //                 child: Text(
//   //                   '돌아가기',
//   //                   style: Theme.of(context)
//   //                       .textTheme
//   //                       .bodyLarge!
//   //                       .copyWith(color: primaryColor),
//   //                 ),
//   //               ),
//   //               TextButton(
//   //                 onPressed: () {
//   //                   _pageController.jumpToPage(1);
//   //                   Navigator.of(context).pop();
//   //                 },
//   //                 child: Text(
//   //                   '다음',
//   //                   style: Theme.of(context)
//   //                       .textTheme
//   //                       .bodyLarge!
//   //                       .copyWith(color: primaryColor),
//   //                 ),
//   //               )
//   //             ],
//   //           )
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }
