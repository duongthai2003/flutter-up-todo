import 'package:flutter/material.dart';

class SplashScreen_2 extends StatelessWidget {
  const SplashScreen_2({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/Vector.png"),
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
