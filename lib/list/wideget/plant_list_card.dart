import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/list/model/list_card_model.dart';
import 'package:plant_plan/utils/colors.dart';

class PlantListCard extends ConsumerWidget {
  final ListCardModel cardData;
  final bool? isdeleteIdList;
  const PlantListCard({super.key, required this.cardData, this.isdeleteIdList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          width: 150.w,
          height: 158.w,
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12.h),
            boxShadow: const [
              BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 8,
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CachedNetworkImage(
                imageUrl: cardData.imageUrl,
                imageBuilder: (context, imageProvider) => ProfileImageWidget(
                  imageProvider: imageProvider,
                  size: 68.h,
                  radius: 28.h,
                ),
                placeholder: (context, url) => SizedBox(
                  width: 68.h,
                  height: 68.h,
                  child: const CircleAvatar(
                    backgroundColor: grayColor200,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Text(
                cardData.title,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: grayBlack,
                    ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h),
                  border:
                      Border.all(width: 1.h, color: const Color(0xFFEDEDED)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 4.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (cardData.fields.isEmpty)
                      Image.asset(
                        'assets/icons/alarm_none.png',
                        width: 16.h,
                        height: 16.h,
                      ),
                    if (cardData.fields.contains(PlantField.watering))
                      Image.asset(
                        'assets/images/management/humid.png',
                        width: 14.h,
                        height: 14.h,
                        fit: BoxFit.contain,
                      ),
                    if (cardData.fields.contains(PlantField.repotting))
                      Image.asset(
                        'assets/images/management/repotting.png',
                        width: 14.h,
                        height: 14.h,
                        fit: BoxFit.contain,
                      ),
                    if (cardData.fields.contains(PlantField.nutrient))
                      Image.asset(
                        'assets/images/management/nutrient.png',
                        width: 14.h,
                        height: 14.h,
                        fit: BoxFit.contain,
                      ),
                    SizedBox(
                      width: 6.h,
                    ),
                    Text(
                      cardData.fields.isEmpty
                          ? '알림 없음'
                          : cardData.dDay == 0
                              ? 'TODAY'
                              : 'D-${cardData.dDay}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: cardData.fields.isEmpty
                                ? const Color(0xFFDEDEDE)
                                : grayColor700,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (cardData.favorite)
          Positioned(
            top: 10.w,
            right: 10.w,
            child: Image.asset(
              'assets/icons/fav/fav_active.png',
              width: 16.w,
              height: 16.w,
            ),
          ),
        if (isdeleteIdList != null && isdeleteIdList!)
          Positioned(
            child: Container(
              width: 150.w,
              height: 158.w,
              decoration: BoxDecoration(
                color: grayBlack.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12.h),
              ),
            ),
          ),
        if (isdeleteIdList != null && isdeleteIdList!)
          Positioned(
            bottom: 8.w,
            right: 8.w,
            child: Image.asset(
              'assets/icons/blue_check.png',
              width: 20.w,
              height: 20.w,
            ),
          ),
      ],
    );
  }
}
