import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:university_nav/view/auth/signupScreen/signup_controller.dart';
import '../../../widgets/rounded_buttom.dart';
import '../loginScreen/login_controller.dart';
import '../loginScreen/login_view.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.orange,
        body: Consumer<SignUpController>(
          builder: (context, signUpController, child) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Image.asset('assets/logo.png',
                          height: 130,
                          colorBlendMode: BlendMode.difference,
                          color: Colors.orange),
                    ),
                    Container(
                      width: double.infinity,
                      height: 800,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Center(
                                child: Text('SignUp',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 28))),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text('Name'),
                            const SizedBox(
                              height: 3,
                            ),
                            TextFormField(
                              controller: signUpController.nameController,
                              cursorColor: Colors.orangeAccent,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Email'),
                            const SizedBox(
                              height: 3,
                            ),
                            TextFormField(
                              controller: signUpController.emailController,
                              cursorColor: Colors.orangeAccent,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Email";
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Password'),
                            const SizedBox(
                              height: 3,
                            ),
                            TextFormField(
                              controller: signUpController.passwordController,
                              cursorColor: Colors.orangeAccent,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your password';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const Text('Confirm Password'),
                            const SizedBox(
                              height: 3,
                            ),
                            TextFormField(
                              controller:
                                  signUpController.confirmPasswordController,
                              cursorColor: Colors.orangeAccent,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Confirm password';
                                }
                                // if (value.length >= 8) {
                                //   return 'Password should be 8 character long';
                                // }
                                if (value !=
                                    signUpController.passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return "";
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 49,
                            ),
                            Center(
                              child: RoundedButton(
                                  buttonText: 'SignUp',
                                  onPress: () {
                                    signUpController.registerUser(
                                        context: context);
                                  },
                                  buttonColor: Colors.orange),
                            ),
                            const SizedBox(
                              height: 33,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.orange,
                                    thickness: 1,
                                    endIndent: 14,
                                  ),
                                ),
                                Text('Already have account?'),
                                Expanded(
                                  child: Divider(
                                    color: Colors.orange,
                                    thickness: 1,
                                    indent: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => LoginScreen());
                              },
                              child: Center(
                                child: RichText(
                                  text: const TextSpan(
                                    text: 'Already have account?',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: " "),
                                      TextSpan(
                                        text: 'Login',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
