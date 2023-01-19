import 'package:flutter/material.dart';
import 'package:plant_plan/widgets/default_grabbing.dart';
import 'package:plant_plan/screens/home_screen.dart';
import 'package:plant_plan/screens/snapping_screen.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SnappingAbove extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  SnappingAbove({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SnappingSheet(
        lockOverflowDrag: true,
        snappingPositions: const [
          SnappingPosition.factor(
            grabbingContentOffset: GrabbingContentOffset.bottom,
            positionFactor: 1,
          ),
          SnappingPosition.factor(
            positionFactor: 0.34,
            grabbingContentOffset: GrabbingContentOffset.top,
          ),
        ],
        grabbingHeight: 88,
        grabbing: const DefaultGrabbing(
          reverse: true,
        ),
        sheetAbove: SnappingSheetContent(
          childScrollController: _scrollController,
          draggable: true,
          child: SnappingScreen(
            reverse: true,
            controller: _scrollController,
          ),
        ),
        child: const HomeScreen(),
      ),
    );
  }
}
