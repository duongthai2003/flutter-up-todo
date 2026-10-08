import 'package:fluter_app/component/buttonBackIcon.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color(0xFF121212),
        leading: buttonBackIcon(onBackPressed: () {}), // icon bên trái
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // buttonBackIcon(onBackPressed: () {}),

              SizedBox(height: 40),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Họ và tên",
                        hintText: "Nhập họ và tên",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập họ và tên';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
