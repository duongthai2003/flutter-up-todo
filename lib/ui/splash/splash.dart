import 'package:fluter_app/ui/auth/login/login.dart';
import 'package:fluter_app/ui/onBoarding/onBoardingPageView.dart';
import 'package:fluter_app/ui/start/startScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _checkAppState(BuildContext context) async {
    // check if the app is already opened
    // kiểm tra xem có kOnboardingCompleted chưa
    final isCompleted = await _isOnboardingCompleted();
    if (isCompleted) {
      // chuyển đến màn hình welcome
      if (!context.mounted) {
        // mounted kiểm tra xem màn hình có đang hiện không
        return;
      }
      // pushReplacement thêm màn hình mới vào stack và xoá màn hình hiện tại --> .pop không quay lại màn trc được vì bị xoad đi r

      // pushReplacement và push khác nhau ở chỗ pushReplacement xoá màn hình hiện tại và thêm màn hình mới vào stack, còn push thì thêm màn hình mới vào stack mà không xoá màn hình hiện tại
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StartScreen(isFirstTimeInstallApp: false),
        ), // false là vì khi từ splash vào thì đã là từng vào app rồi
      );
    } else {
      if (!context.mounted) {
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnBoardingPageView()),
      );
    }
  }

  Future<bool> _isOnboardingCompleted() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance(); // getInstance là lấy instance của shared preferences
      final result = prefs.getBool(
        "kOnboardingCompleted",
      ); // getBool là lấy dữ liệu từ shared preferences. getBool(keyName)
      return result ?? false;
    } catch (error) {
      print("Error checking onboarding completion: $error");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkAppState(context);
    // TODO: implement

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/Vector.png",
                width: 95,
                height: 80,
                fit: BoxFit.contain,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  "UpTodo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
