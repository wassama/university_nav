import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_nav/view/auth/loginScreen/login_view.dart';
import '../../cosntants/constant.dart';
import '../Onboarding/onboarding_screen.dart';
import '../home/home_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      if(user != null || prefs.getString(AppConstant.isSkipped) != null){
        Get.offAll(() => const HomeScreen());
      }else if (prefs.getString(AppConstant.onBoarding) == null) {
        Get.offAll(OnboardingScreen());
      } else {
        AppConstant.getOnBoarding = prefs.getString(AppConstant.onBoarding).toString();
        Navigator.push(context, MaterialPageRoute( builder: (context) => LoginScreen(),
            ));
        // Set AppConstant values
      }
    });
  }
  void checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    // AppConstant.getUserType =
    //     prefs.getString(AppConstant.saveUserType).toString();
    if (user != null) {
      /// Checking User exists or not
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Center(
                child: Image.asset('assets/logo.png',width: 350,height: 240),
              )),
        ],
      ),
    );
  }
}
