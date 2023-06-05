import 'package:api_app/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base_views/views/home_views/home_page.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(const HomePage());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(rider),
      ),
    );
  }
}
