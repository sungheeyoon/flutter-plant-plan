import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/utils/colors.dart';

class ProgressBar extends StatelessWidget {
  final int pageIndex;

  const ProgressBar({
    super.key,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (pageIndex == 0) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 34.h,
                child: CircleAvatar(
                  radius: 12.h,
                  backgroundColor: keyColor500,
                  child: Text(
                    '1',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  indent: 6.0,
                  endIndent: 6.0,
                  thickness: 1.h,
                  color: keyColor300,
                ),
              ),
              SizedBox(
                width: 34.h,
                child: CircleAvatar(
                  radius: 12.h,
                  backgroundColor: keyColor300,
                  child: CircleAvatar(
                    radius: 11.h,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  indent: 6.0,
                  endIndent: 6.0,
                  thickness: 1.h,
                  color: keyColor300,
                ),
              ),
              SizedBox(
                width: 34.h,
                child: CircleAvatar(
                  radius: 12.h,
                  backgroundColor: keyColor300,
                  child: CircleAvatar(
                    radius: 11.h,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 34.h,
                child: Text(
                  '정보추가',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: keyColor600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 34.h,
                child: Text(
                  '알림추가',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: keyColor400,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 34.h,
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
      );
    } else if (pageIndex == 1) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 34.h,
                child: CircleAvatar(
                  radius: 12.h,
                  backgroundColor: keyColor300,
                  child: Text(
                    '1',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  indent: 6.0,
                  endIndent: 6.0,
                  thickness: 1.h,
                  color: keyColor500,
                ),
              ),
              SizedBox(
                width: 34.h,
                child: CircleAvatar(
                  radius: 12.h,
                  backgroundColor: keyColor500,
                  child: Text(
                    '2',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  indent: 6.0,
                  endIndent: 6.0,
                  thickness: 1.h,
                  color: keyColor300,
                ),
              ),
              SizedBox(
                width: 34.h,
                child: CircleAvatar(
                  radius: 12.h,
                  backgroundColor: keyColor300,
                  child: CircleAvatar(
                    radius: 11.h,
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
                width: 34.h,
                child: Text(
                  '정보추가',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: keyColor300,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 34.h,
                child: Text(
                  '알림추가',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: keyColor600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 34.h,
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
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 34,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: keyColor300,
                  child: Text(
                    '1',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
                  color: keyColor500,
                ),
              ),
              SizedBox(
                width: 34,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: keyColor300,
                  child: Text(
                    '2',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
                  color: keyColor500,
                ),
              ),
              SizedBox(
                width: 34,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: keyColor500,
                  child: Text(
                    '3',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
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
                        color: keyColor300,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 34,
                child: Text(
                  '알림추가',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: keyColor300,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 34,
                child: Text(
                  '추가완료',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: keyColor600,
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ],
      );
    }
  }
}
