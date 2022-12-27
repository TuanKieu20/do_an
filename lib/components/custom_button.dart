import 'package:flutter/material.dart';
import 'package:do_an/constants.dart';

import '../Helper/styles.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final bool? transparent;
  final double? fontSize;
  final double? radius;
  final IconData? icon;
  final Color? backgroundColor;
  final bool? showShadow;
  final Color? shadowColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final bool isLoading;
  final TextStyle? textStyle;

  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.fontSize,
      this.radius,
      this.icon,
      this.backgroundColor,
      this.showShadow,
      this.shadowColor,
      this.padding,
      this.isLoading = false,
      this.textStyle,
      this.margin,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? kPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 40))),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 40)),
        onTap: () {
          if (onPressed != null && !isLoading) {
            onPressed!();
          }
        },
        child: Container(
          height: height ?? 48,
          width: width,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 3)
              : Text(buttonText,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      mikado500.copyWith(fontSize: fontSize ?? 20)),
        ),
      ),
    );
  }
}
