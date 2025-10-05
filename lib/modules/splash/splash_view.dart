import 'package:taposurakkha/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/beautiful_loader.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    redirectUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.appBaseColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 150, height: 150, child: Image.asset('assets/images/logo.png')),
              SizedBox(height: 24),
            Text('তাপসুরক্ষা', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            BeautifulLoader()
            ],
          ),
        ),
      ),
    );
  }

  void redirectUser() async {

    Future.delayed(Duration(seconds: 1), () {
      Get.offAllNamed(AppRoutes.dashboard);
    });
  }
}