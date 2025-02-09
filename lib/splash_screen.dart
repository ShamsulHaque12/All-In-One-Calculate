import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateHome() {
    Future.delayed(Duration(seconds: 4)).then((onValue) {
      Get.off(HomeScreen());
    });
  }

  @override
  void initState() {
    super.initState();
    navigateHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "All In One Calculator",
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 5),
            Image.asset("assets/images/alinonecalculator.jpg"),
          ],
        ),
      ),
    );
  }
}
