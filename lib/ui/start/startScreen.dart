import 'package:fluter_app/component/buttonBackIcon.dart';
import 'package:fluter_app/component/OutlinedLoginButton.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onBackPressed;
  const StartScreen({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 60,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 24),
                    child: buttonBackIcon(onBackPressed: onBackPressed),
                  ),
                  _buildContent(),
                ],
              ),
            ),
            _bottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 42),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // căn giữa theo chiều ngang
        spacing: 26,

        children: [
          Text(
            "Welcome to UpTodo",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Please login to your account or create new account to continue",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.67),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 64),

      child: Column(
        spacing: 28,
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // chiếm toàn bộ chiều ngang của container
        children: [
          ElevatedButton(
            // ElevatedButton tạo button nền màu
            onPressed: () {
              print("login");
            },
            child: Text(
              "Login".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              minimumSize: Size.fromHeight(48),
            ),
          ),
          OutlinedLoginButton(label: "Create account"),
        ],
      ),
    );
  }
}
