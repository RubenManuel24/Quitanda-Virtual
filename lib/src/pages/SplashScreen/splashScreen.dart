import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/custom_colors.dart';
import '../auth/controller/auth_controller.dart';
import '../common_widgets/app_name_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Get.find<AuthController>().validateToken();
    
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CustomColors.customSwatchColor,
            CustomColors.customSwatchColor.shade700
          ],
        )),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppNameWidget(
              sizeGreen: 40,
              colorGreen: Colors.white,
            ),
            const SizedBox(height: 10),
            CircularProgressIndicator(
              backgroundColor: CustomColors.customContrastColor,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
