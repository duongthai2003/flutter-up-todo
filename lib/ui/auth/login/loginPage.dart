import 'package:easy_localization/easy_localization.dart';
import 'package:fluter_app/component/OutlinedLoginButton.dart';
import 'package:fluter_app/component/PrimaryButton.dart';
import 'package:fluter_app/ui/auth/login/bloc/login_cubit.dart';
import 'package:fluter_app/ui/auth/register/registerPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24).copyWith(top: 41),
        child: SafeArea(
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
      ),
    );
  }

  Widget _pageTitle() {
    return Text(
      "login".tr(),
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.87),
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFormLogin() {
    return Form(
      key: _formKey,
      autovalidateMode:
          _autoValidateMode, // khi user vào lần đầu tiên thì sẽ không validate
      child: Container(
        margin: EdgeInsets.only(top: 53),
        child: Column(
          spacing: 25,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.87),
                  ),
                ),
                TextFormField(
                  controller: _emailTextController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your Email",
                    hintStyle: TextStyle(
                      color: Color(0xFF535353),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF979797),
                      ),
                    ),
                    fillColor: Color(0xFF1D1D1D),
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email is required";
                    }
                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(value.trim())) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
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
                  controller: _passwordTextController,
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
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF979797),
                      ),
                    ),
                    fillColor: Color(0xFF1D1D1D),
                    filled: true,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required";
                    }
                    if (value.trim().length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.only(top: 45),
              child: PrimaryButton(
                onPressed: _onHandleLoginSubmit,
                label: "login".tr().toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onHandleLoginSubmit() {
    final loginCubit = context.read<LoginCubit>();
    final email = _emailTextController.text;
    final password = _passwordTextController.text;
    loginCubit.login(email, password);

    final isValid = _formKey.currentState!.validate();

    if (_autoValidateMode == AutovalidateMode.disabled) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }

    if (isValid) {
      print("Login successful");
    } else {
      //
    }
  }

  Widget _buildSocialLogin() {
    return Container(
      child: Column(
        spacing: 20,
        children: [
          OutlinedLoginButton(
            label: "Login with Google",
            icon: Image.asset("assets/images/google.png"),
          ),
          OutlinedLoginButton(
            label: "Login with Apple",
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
          text: "Don't have an account? ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF979797),
          ),
          children: [
            TextSpan(
              text: "Register",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // điều hướng đến trang đăng ký
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
