import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/plant_provider.dart';
import 'package:plant_plan/add/widget/progress_bar.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AddSecondScreen extends ConsumerWidget {
  const AddSecondScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlant = ref.watch(selectedPlantProvider);
    final selectedPhoto = ref.watch(photoProvider);
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
            const ProgressBar(pageIndex: 1),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                width: 360.w,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.w),
                  boxShadow: [
                    BoxShadow(
                      color: grayBlack.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(2, 2), // Shadow position
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Stack(
                          children: [
                            if (selectedPhoto != null) //찍은애
                              Stack(children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: CircleAvatar(
                                    radius: 18.h, // Image radius
                                    backgroundImage: FileImage(selectedPhoto),
                                  ),
                                ),
                              ])
                            else if (selectedPlant != null) //안찍었는데 깟다왓어
                              FittedBox(
                                fit: BoxFit.contain,
                                child: CircleAvatar(
                                  radius: 18.w, // Image radius
                                  backgroundImage:
                                      NetworkImage(selectedPlant.image),
                                ),
                              )
                            else
                              const ImageBox(
                                imageUri: 'assets/images/pot.png',
                                width: 36,
                                height: 36,
                              ),
                          ],
                        ),
                      ],
                    ),
                    if (selectedPlant != null)
                      Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            selectedPlant.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: grayBlack,
                                ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
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
