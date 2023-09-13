import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/utils/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Color? titleBackgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? actions;
  final Widget? leading;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.titleBackgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.actions,
    this.leading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(context),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: false,
      body: child,
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        toolbarHeight: 56.h,
        backgroundColor: titleBackgroundColor ?? Colors.white,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        title: Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: primaryColor),
        ),
        foregroundColor: primaryColor,
        actions: actions,
        leading: leading,
      );
    }
  }
}
