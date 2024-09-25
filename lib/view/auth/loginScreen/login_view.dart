import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_nav/view/home/home_screen.dart';
import '../../../cosntants/constant.dart';
import '../signupScreen/signup_view.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<LoginController>(
          builder: (context, loginController, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.orange,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 200.0,
                      child: Image.asset('assets/logo.png',
                          colorBlendMode: BlendMode.difference,
                          color: Colors.orange),
                    ),
                    const SizedBox(height: 48.0),
                    Container(
                      width: double.infinity,
                      height: 600,
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
                              child: Text('Login',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text('Email'),
                            const SizedBox(
                              height: 3,
                            ),
                            TextFormField(
                              controller: loginController.emailController,
                              cursorColor: Colors.orangeAccent,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text('Password'),
                            const SizedBox(
                              height: 3,
                            ),
                            TextFormField(
                              controller: loginController.passwordController,
                              cursorColor: Colors.orangeAccent,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Center(
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    fixedSize: MaterialStatePropertyAll(Size(250, 44)),
                                    backgroundColor: MaterialStatePropertyAll(Colors.orange)),
                                onPressed: () {
                                  loginController.loginUser(context);
                                },
                                child: const Text('Login', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.orange,
                                    thickness: 1,
                                    // indent: 61,
                                    endIndent: 14,
                                  ),
                                ),
                                Text(
                                  'Don\'t have account',

                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.orange,
                                    thickness: 1,
                                    indent: 14,
                                    // endIndent: 61,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 22),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SignUpScreen());
                              },
                              child: Center(
                                child: RichText(
                                  text: const TextSpan(
                                    text: 'Don\'t have account',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: " "),
                                      TextSpan(
                                        text: 'SignUp',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            // Center(
                            //   child: ElevatedButton(
                            //     style: const ButtonStyle(
                            //         fixedSize: MaterialStatePropertyAll(Size(250, 44)),
                            //         backgroundColor: MaterialStatePropertyAll(Colors.orange)),
                            //     onPressed: () {
                            //       // loginController.loginUser(context);
                            //     },
                            //     child: const Text('Skip', style: TextStyle(color: Colors.white)),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: ClipOval(
                child: ElevatedButton(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orange)),
                    onPressed: () async{
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString(AppConstant.isSkipped, 'isSkipped');
                      AppConstant.getIsSkipped = prefs.getString(AppConstant.isSkipped)!;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }, child: Text('Skip', style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ))),
              ),
            );
          },
        ),
      ),
    );
  }
}
