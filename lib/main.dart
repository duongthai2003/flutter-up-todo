import 'package:fluter_app/ui/main/mainPage.dart';
import 'package:fluter_app/ui/onBoarding/onBoardingPageView.dart';
import 'package:fluter_app/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Demo Course',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      home: const MainPage(),
    );
  }
}
