import 'package:easy_localization/easy_localization.dart';
import 'package:fluter_app/component/buttonBackIcon.dart';
import 'package:fluter_app/component/OutlinedLoginButton.dart';
import 'package:fluter_app/ui/onBoarding/onBoardingPageView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatelessWidget {
  final bool isFirstTimeInstallApp;
  const StartScreen({super.key, required this.isFirstTimeInstallApp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: isFirstTimeInstallApp
            ? buttonBackIcon(
                onBackPressed: () => {
                  // check xem có thể pop không, nếu có thì pop
                  // pop là xoá màn hình hiện tại trở về màn hình trước

                  if (Navigator.canPop(context)) {Navigator.pop(context)},
                },
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 60,
                children: [SizedBox(height: 0), _buildContent()],
              ),
            ),
            _bottomButton(context),
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
            "welcome_title".tr(),
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "welcome_description".tr(),
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

  Widget _bottomButton(BuildContext context) {
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
              // lấy ra ngôn ngữ hiện tại
              final curentLanguage = context.locale.toString();
              if (curentLanguage == "en") {
                context.setLocale(Locale("vi"));
              } else {
                context.setLocale(Locale("en"));
              }
            },
            child: Text(
              "change_language".tr(),
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
          ElevatedButton(
            // ElevatedButton tạo button nền màu
            onPressed: () {
              print("login");
            },
            child: Text(
              "login".tr().toUpperCase(),
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
          OutlinedLoginButton(label: "create_account".tr()),
        ],
      ),
    );
  }
}
