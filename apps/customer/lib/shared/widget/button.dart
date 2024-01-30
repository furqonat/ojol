import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final Widget? icon;
  const Button({
    Key? key,
    required this.onPressed,
    required this.child,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 5,
          fixedSize: Size(Get.width * 0.5, Get.height * 0.07),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          backgroundColor: const Color(0xFF3978EF)),
      child: child,
    );
  }
}
