import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: DiaryLoadingScreen(),
      ),
    );
  }
}

class DiaryLoadingScreen extends StatelessWidget {
  const DiaryLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.black.withOpacity(0.7),
      content: const SizedBox(
        width: 10000,
        height: 10000,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
