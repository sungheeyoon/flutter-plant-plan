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
      theme: ThemeData(
          fontFamily: 'Pretendard',
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
            displayMedium: TextStyle(
              fontSize: 24.0,
              letterSpacing: -1,
            ),
            displaySmall: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
            headlineLarge: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
            headlineMedium: TextStyle(
              fontSize: 20.0,
              letterSpacing: -0.8,
            ),
            headlineSmall: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.7),
            titleLarge: TextStyle(
              fontSize: 18.0,
              letterSpacing: -0.7,
            ),
            titleMedium: TextStyle(
              fontSize: 16.0,
              letterSpacing: -0.6,
            ),
            bodyLarge: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.6),
            bodyMedium: TextStyle(
              fontSize: 14.0,
              letterSpacing: -0.6,
            ),
            bodySmall: TextStyle(
              fontSize: 12.0,
              letterSpacing: -0.5,
            ),
            labelLarge: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.6),
            labelMedium: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5),
            labelSmall: TextStyle(
              fontSize: 10.0,
              letterSpacing: -0.4,
            ),
          ).apply(decorationColor: Colors.orange)),
      home: SnappingAbove(),
    );
  }
}
