import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/widget/rounded_button.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AddFirstScreen extends StatelessWidget {
  const AddFirstScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8.0,
            ),
            // top prograss bar
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 34,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: keyColor500,
                        child: Text(
                          '1',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        indent: 6.0,
                        endIndent: 6.0,
                        thickness: 1,
                        color: keyColor300,
                      ),
                    ),
                    const SizedBox(
                      width: 34,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: keyColor300,
                        child: CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        indent: 6.0,
                        endIndent: 6.0,
                        thickness: 1,
                        color: keyColor300,
                      ),
                    ),
                    const SizedBox(
                      width: 34,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: keyColor300,
                        child: CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 34,
                      child: Text(
                        '정보추가',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: keyColor600,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 34,
                      child: Text(
                        '알림추가',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: keyColor400,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 34,
                      child: Text(
                        '추가완료',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: keyColor400,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            // photo and search box
            Center(
              child: Container(
                width: 360.w,
                height: 172,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: grayBlack.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(2, 2), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Stack(
                            children: [
                              // if (pickedFile != null) //찍은애
                              //   FittedBox(
                              //       fit: BoxFit.contain,
                              //       child: CircleAvatar(
                              //           radius: 40, // Image radius
                              //           backgroundImage: FileImage(
                              //               File(pickedFile!.path))))
                              // else if (widget.prev?.image != null) //찍엇는데 갔다왓음
                              //   FittedBox(
                              //       fit: BoxFit.contain,
                              //       child: CircleAvatar(
                              //           radius: 40, // Image radius
                              //           backgroundImage: FileImage(
                              //               File(widget.prev!.image!.path))))
                              // else if (widget.document != null) //안찍었는데 깟다왓어
                              //   FittedBox(
                              //     fit: BoxFit.contain,
                              //     child: CircleAvatar(
                              //         radius: 40, // Image radius
                              //         backgroundImage: NetworkImage(
                              //             widget.document!.image)),
                              //   )
                              // else
                              ImageBox(
                                imageUri: 'assets/images/pot.png',
                                width: 80,
                                height: 80,
                              ),
                              Positioned(
                                right: 1,
                                top: 1,
                                child: ImageBox(
                                  imageUri: 'assets/icons/x.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          backgroundColor: Colors.white,
                          borderColor: pointColor2.withOpacity(
                            0.5,
                          ),
                          width: 136,
                          height: 32,
                          textColor: pointColor2,
                          name: '사진 추가',
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        RoundedButton(
                          backgroundColor: Colors.white,
                          borderColor: pointColor2.withOpacity(
                            0.5,
                          ),
                          width: 136,
                          height: 32,
                          textColor: pointColor2,
                          name: '종류 검색',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            //별칭
            Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16),
                      hintText: '내 식물의 별칭을 입력해주세요',
                      hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: grayColor400,
                              ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: keyColor500,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: grayColor400,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 0,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: Text('별칭(선택)',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: grayColor600,
                                  )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            //물주기 ontap version
            Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16),
                      hintText: '마지막으로 물 준 날을 선택해주세요',
                      hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: grayColor400,
                              ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: keyColor500,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: grayColor400,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 0,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: Text(
                        '물주기',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: grayColor600,
                            ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 13,
                  child: Container(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: ImageBox(
                        imageUri: 'assets/icons/calendar_box.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ElevatedButton(
            //     onPressed: uploadFile, child: const Text("예비 업로드버튼")),
          ],
        ),
      ),
    );
  }
}
