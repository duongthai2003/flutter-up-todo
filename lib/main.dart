import 'package:easy_localization/easy_localization.dart';
import 'package:fluter_app/ui/auth/login/login.dart';
import 'package:fluter_app/ui/category/createOrEditCategory.dart';
import 'package:fluter_app/ui/main/mainPage.dart';
import 'package:fluter_app/ui/onBoarding/onBoardingPageView.dart';
import 'package:fluter_app/ui/splash/splash.dart';
import 'package:fluter_app/ui/start/startScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // khởi tạo EasyLocalization để sử dụng đa ngôn ngữ
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    // thêm các loại ngôn ngữ được hỗ trợ
    EasyLocalization(
      supportedLocales: const [Locale("en"), Locale("vi")],
      path: "assets/translations",

      child: const MyApp(),
    ),
  );
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
      // khai báo các thuộc tính của EasyLocalization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const CreateOrEditCategory(),
    );
  }
}
