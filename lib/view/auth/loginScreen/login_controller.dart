
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_nav/view/home/home_screen.dart';

import '../../../cosntants/constant.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool isLoading = false;

  void setLoading(value) {
    isLoading = !value;
    notifyListeners();
  }

  void loginUser(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: AppConstant.spinKitCircle());
      },
      barrierDismissible: false,
    );
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),

      );
      // Dismiss the dialog before navigating
      // Navigator.pop(context);
      // Navigate to the home screen after successful login
      Get.offAll(() => const HomeScreen());
      AppConstant().toastMassage("Login Successfully", false);
    } on FirebaseAuthException catch (e) {

      print("%%%%%%%%%%%%%%%%%%%%%%%% ERROR %%%%%%%% ========: $e");
      AppConstant().toastMassage(e.toString(), true);

      Navigator.pop(context);
    }
  }



}

