import 'package:flutter/material.dart';
import 'package:do_an/Helper/styles.dart';
import 'package:do_an/constants.dart';

import 'custom_button.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({
    Key? key,
    required this.labelText,
    this.buttonText,
    required this.onPressed,
    this.labelStyle,
    this.padding,
    this.backgroundColor,
    this.isShowContact = false,
  }) : super(key: key);
  final TextStyle? labelStyle;
  final String labelText;
  final String? buttonText;
  final Function onPressed;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool? isShowContact;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              labelText,
              textAlign: TextAlign.center,
              style: labelStyle ??
                  mikado500.copyWith(
                      fontSize: 18, height: 1.5, color: Colors.black),
            ),
            const SizedBox(height: 30),
            CustomButton(
                backgroundColor: backgroundColor ?? kPrimaryColor,
                // height: ScreenUtil().setHeight(54),
                radius: 54,
                buttonText: buttonText ?? 'Xác nhận',
                showShadow: true,
                shadowColor: backgroundColor ?? kPrimaryColor,
                onPressed: () {
                  onPressed();
                }),
          ],
        ),
      ),
    );
  }
}
