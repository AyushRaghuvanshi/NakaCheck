import 'package:firebase_core/firebase_core.dart';
import 'package:nakacheck/core/notifications/notification_handler.dart';
import 'package:nakacheck/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    notificationInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NakaCheck',
      theme: ThemeData.dark().copyWith(
          colorScheme:
              const ColorScheme.light().copyWith(primary: Color(0xFFF1F4F6))),
      home: OnboardingScreen(),
    );
  }
}
