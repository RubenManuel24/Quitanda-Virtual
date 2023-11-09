import 'package:flutter/material.dart';
import '../../config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  final Color? colorGreen;
  final double sizeGreen;

    const AppNameWidget({super.key, 
    this.sizeGreen = 30,
    this.colorGreen
  });

   @override
   Widget build(BuildContext context) {
       return Text.rich(
            TextSpan(
                style:  TextStyle(
                  fontSize: sizeGreen,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: "Green",
                      style: TextStyle(
                        color: colorGreen ?? CustomColors.customSwatchColor,
                      )),
                  TextSpan(
                      text: "grocer",
                      style: TextStyle(
                        color: CustomColors.customContrastColor,
                      )),
                ]),
          );
  }
}