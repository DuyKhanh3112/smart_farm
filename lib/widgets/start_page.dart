import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_ai/config/app_colors.dart';
import 'package:farm_ai/controller/smart_farm/start_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StartController());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/bg_start.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            // Image.asset("assets/images/logo_seacorp.png"),
            // Image.asset("assets/images/farm.jpeg"),
            LoadingAnimationWidget.hexagonDots(color: Colors.white, size: 50),
          ],
        ),
      ),
    );
  }
}
