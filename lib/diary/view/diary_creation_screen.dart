import 'package:flutter/material.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/utils/colors.dart';

class DiaryCreationScreen extends StatefulWidget {
  const DiaryCreationScreen({super.key});

  @override
  State<DiaryCreationScreen> createState() => _DiaryCreationScreenState();
}

class _DiaryCreationScreenState extends State<DiaryCreationScreen> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '다이어리 작성',
      actions: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(right: 24),
            disabledForegroundColor: const Color(0xFF999999).withOpacity(0.38),
          ),
          child: Text(
            '완료',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: pointColor2),
          ),
        )
      ],
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: DropdownButtonFormField<String>(
              value: _selectedItem,
              icon: const Icon(Icons.chevron_right),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                labelText: '식물을 선택해주세요',
                labelStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
              },
              items: const [
                DropdownMenuItem(value: 'item1', child: Text('아이템 1')),
                DropdownMenuItem(value: 'item2', child: Text('아이템 2')),
                DropdownMenuItem(value: 'item3', child: Text('아이템 3')),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 8,
            color: grayColor100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '제목',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grayBlack),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Image(
                    image: AssetImage('assets/icons/edit.png'),
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: const IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '내용을 입력해주세요',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                maxLines: null,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Divider(
                                  thickness: 1,
                                  color: grayColor200,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Row(
                                    children: [
                                      Image(
                                        image:
                                            AssetImage('assets/icons/edit.png'),
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("사진추가 (최대 10 장)")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           const Expanded(
          //             child: TextField(
          //               decoration: InputDecoration(
          //                 hintText: '제목',
          //                 hintStyle: TextStyle(color: Colors.grey),
          //                 enabledBorder: UnderlineInputBorder(
          //                   borderSide: BorderSide(color: Colors.grey),
          //                 ),
          //                 focusedBorder: UnderlineInputBorder(
          //                   borderSide: BorderSide(color: grayBlack),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           IconButton(
          //             icon: const Image(
          //               image: AssetImage('assets/icons/edit.png'),
          //               width: 24,
          //               height: 24,
          //             ),
          //             onPressed: () {
          //               // 아이콘 버튼이 클릭되었을 때 수행할 동작
          //             },
          //           ),
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 16,
          //       ),

          //       const Expanded(
          //         child: TextField(
          //           decoration: InputDecoration(
          //             hintText: '내용을 입력해주세요',
          //             hintStyle: TextStyle(color: Colors.grey),
          //             border: InputBorder.none,
          //           ),
          //           maxLines: null,
          //         ),
          //       ),
          //       const Divider(
          //         thickness: 1,
          //         color: grayColor100,
          //       ),
          //       Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Padding(
          //           padding: const EdgeInsets.only(bottom: 30),
          //           child: TextButton(
          //             onPressed: () {
          //               // 하단 버튼이 클릭되었을 때 수행할 동작
          //             },
          //             child: const Text('하단 버튼'),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
