import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:university_nav/view/auth/loginScreen/login_controller.dart';
import 'package:university_nav/view/profile/profile_controller.dart';
import 'package:university_nav/view/splash/splash_view.dart';
import 'firebase_options.dart';
import 'view/auth/signupScreen/signup_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => SignUpController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          textTheme:  const TextTheme(bodyLarge: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.white),
              bodyMedium:  TextStyle(color: Colors.white)),
          useMaterial3: true,
        ),
        home: SplashView(),
      ),
    );
  }
}
