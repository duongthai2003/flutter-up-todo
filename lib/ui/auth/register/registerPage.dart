import 'package:easy_localization/easy_localization.dart';
import 'package:fluter_app/component/OutlinedLoginButton.dart';
import 'package:fluter_app/component/PrimaryButton.dart';
import 'package:fluter_app/ui/auth/login/loginPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pageTitle(),
            _buildFormLogin(),
            _buildDivider(),
            _buildSocialLogin(),
            _buildHaveNoAccount(),
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return Text(
      "auth.register".tr(),
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.87),
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFormLogin() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        spacing: 25,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Username",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.87),
                ),
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: "Enter your Username",
                  hintStyle: TextStyle(
                    color: Color(0xFF535353),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(width: 1, color: Color(0xFF979797)),
                  ),
                  fillColor: Color(0xFF1D1D1D),
                  filled: true,
                ),
              ),
            ],
          ),
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.87),
                ),
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: "Enter your Password",
                  hintStyle: TextStyle(
                    color: Color(0xFF535353),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(width: 1, color: Color(0xFF979797)),
                  ),
                  fillColor: Color(0xFF1D1D1D),
                  filled: true,
                ),
                obscureText: true,
              ),
            ],
          ),
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.87),
                ),
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: "Enter your Password",
                  hintStyle: TextStyle(
                    color: Color(0xFF535353),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(width: 1, color: Color(0xFF979797)),
                  ),
                  fillColor: Color(0xFF1D1D1D),
                  filled: true,
                ),
                obscureText: true,
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 45),
            child: PrimaryButton(
              onPressed: () {},
              label: "register".tr().toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Container(
      child: Column(
        spacing: 20,
        children: [
          OutlinedLoginButton(
            label: "Register with Google",
            icon: Image.asset("assets/images/google.png"),
          ),
          OutlinedLoginButton(
            label: "Register with Apple",
            icon: Image.asset("assets/images/apple.png"),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        spacing: 8,
        children: [
          Expanded(child: Divider(color: Color(0xFF979797), height: 1)),
          Text(
            "or",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF979797),
            ),
          ),
          Expanded(child: Divider(color: Color(0xFF979797), height: 1)),
        ],
      ),
    );
  }

  Widget _buildHaveNoAccount() {
    return Container(
      margin: EdgeInsets.only(top: 46, bottom: 20),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF979797),
          ),
          children: [
            TextSpan(
              text: "login".tr(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
