import 'package:flutter/material.dart';
import 'package:plant_plan/add/widget/progress_bar.dart';

class AddThirdScreen extends StatelessWidget {
  const AddThirdScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.0,
            ),
            ProgressBar(pageIndex: 2),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
