import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 576;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 576 &&
      MediaQuery.of(context).size.width <= 992;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 992;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, contrainst) {
      if (contrainst.maxWidth > 992) {
        // Get.find<HomeController>().update();
        return desktop;
      } else if (contrainst.maxWidth >= 576 && tablet != null) {
        // Get.find<HomeController>().update();
        return tablet!;
      } else {
        // Get.find<HomeController>().update();
        return mobile;
      }
    });
  }
}
