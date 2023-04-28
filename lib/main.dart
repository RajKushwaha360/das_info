import 'package:das_info/screens/authentication/login_page.dart';
import 'package:das_info/screens/home/home_page.dart';
import 'package:das_info/screens/introduction/introduction_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
    
  );
  await GetStorage.init();
  await getData();
  runApp(const MyApp());
}

bool isFirstTime = true;
bool isLogin = true;

Future<void> getData() async {
  final data = GetStorage();
  if (data.read("isFirstTime") == null) {
    isFirstTime = true;
  } else {
    isFirstTime = data.read("isFirstTime");
  }
  final auth = FirebaseAuth.instance;
  final currentUser = auth.currentUser;
  if (currentUser == null) {
    isLogin = false;
  }
}

getMaterialPage() {
  if (isFirstTime) {
    return IntroductionScreen();
  } else {
    if (isLogin) {
      return const HomePage();
    } else {
      return LogIn();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VGEC Hotel',
      // theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      // darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: getMaterialPage(),
    );
  }
}
