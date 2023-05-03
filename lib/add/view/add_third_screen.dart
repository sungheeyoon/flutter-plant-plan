import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/add/provider/plant_provider.dart';
import 'package:plant_plan/add/widget/progress_bar.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AddThirdScreen extends ConsumerWidget {
  const AddThirdScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlant = ref.watch(selectedPlantProvider);
    final selectedPhoto = ref.watch(photoProvider);
    final plantState = ref.watch(plantInformationProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.h,
            ),
            const ProgressBar(pageIndex: 2),
            SizedBox(
              height: 32.h,
            ),
            Center(
              child: Container(
                width: 360.w,
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.h),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (selectedPhoto != null) //찍은애
                      Stack(children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: CircleAvatar(
                            radius: 30.h, // Image radius
                            backgroundImage: FileImage(selectedPhoto),
                          ),
                        ),
                      ])
                    else if (selectedPlant != null) //안찍었는데 깟다왓어
                      FittedBox(
                        fit: BoxFit.contain,
                        child: CircleAvatar(
                          radius: 30.h, // Image radius
                          backgroundImage: NetworkImage(selectedPlant.image),
                        ),
                      )
                    else
                      ImageBox(
                        imageUri: 'assets/images/pot.png',
                        width: 60.h,
                        height: 60.h,
                      ),
                    SizedBox(
                      height: 12.h,
                    ),
                    if (selectedPlant != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.h,
                          vertical: 2.h,
                        ),
                        color: keyColor100,
                        child: Center(
                          child: Text(
                            selectedPlant.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: keyColor700,
                                ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
