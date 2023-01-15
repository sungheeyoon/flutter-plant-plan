import 'package:flutter/material.dart';
import 'package:plant_plan/widgets/snapping_above.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard'),
      home: SnappingAbove(),
    );
  }
}
