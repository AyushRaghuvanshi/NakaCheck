import 'package:nakacheck/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:nakacheck/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
