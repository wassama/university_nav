import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cosntants/constant.dart';
import '../loginScreen/login_view.dart';

class AppConstants {
  static String? userId;
}

class SignUpController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  bool isLoading = false;
  bool isLoading1 = false;
  bool isNavigate = false;

  /// user registration
  void registerUser(
      {required BuildContext context}) async {
    final _name = nameController.text.trim();
    final _email = emailController.text.trim();
    final _password = passwordController.text.trim();
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: AppConstant.spinKitCircle());
      },
      barrierDismissible: false,
    );
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        signUpUser(_name, _email, context);
      });
    } on FirebaseAuthException catch (e) {
      // Firebase Authentication errors
      String errorMessage = 'An error occurred';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      AppConstant().toastMassage(errorMessage, true);
      if (kDebugMode) {
        print("Signup Failed: ${e.message}");
      }
      Navigator.pop(context);
    } catch (e) {
      // Other errors
      if (kDebugMode) {
        print("Signup Failed: $e");
      }
    }
    Navigator.pop(context);
  }


  Future<void> signUpUser(
      String userName,
      String userEmail,
      BuildContext context,
      ) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;

    try {
      // Create a user document in Firestore
      var type = "users";
      await FirebaseFirestore.instance.collection(type).doc(_uid).set({
        'id': _uid,
        'userName': userName,
        'email': userEmail,
      }).then((_) {
        print("Realtime Database: User entry created successfully");
        // Show a success message, sign out, and navigate to the login screen
        AppConstant().toastMassage('User Created Successfully', true);
        FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }).catchError((e) {
        AppConstant()
            .toastMassage('Error creating user document in Firestore', false);
        print("Firestore Error: $e");
      });
    } catch (e) {
      AppConstant().toastMassage('User Already Exists', false);
      print("Error: $e");
    }
  }
}
