import 'package:fluter_app/ui/start/startScreen.dart';
import 'package:fluter_app/ultils.emuns/OnboardingPagePosition.dart';
import 'package:flutter/material.dart';

typedef OnboardingItemType = ({
  String title,
  String content,
  String? image,
  int index,
  VoidCallback onBackPressed,
  VoidCallback onNextPressed,
});

class OnBoardingChildPage extends StatelessWidget {
  // final OnboardingPagePosition onboardingPagePosition;
  // final VoidCallback onNextPressed;
  // final VoidCallback onBackPressed;

  final OnboardingItemType onboardingItem; // khai báo biến ==> props

  const OnBoardingChildPage({
    super.key,
    // required this.onboardingPagePosition,
    // required this.onNextPressed,
    // required this.onBackPressed,
    required this.onboardingItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            // Expanded chiếm hết chỗ còn lại phía trên. Màn hình đủ cao thì nội dung nằm trên, nút nằm dưới. Màn hình ngắn thì chỉ phần trên cuộn, nút Back/Next thì fixed ở dưới
            Expanded(
              child: Column(
                children: [
                  _buildSkipButton(),
                  _buildOnBoardingImage(),
                  _buildOnBoardingPageControl(),
                  _buildOnBoardingTitleAndContent(),
                ],
              ),
            ),
            _buildOnBoardingNextAndPrevButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Container(
      margin: EdgeInsets.only(top: 14),
      alignment: Alignment.centerLeft,

      child: TextButton(
        onPressed: () => {},
        child: Text(
          "Skip",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.44),
          ),
        ),
      ),
    );
  }

  Widget _buildOnBoardingImage() {
    return Image.asset(
      onboardingItem.image ?? "",
      width: 296,
      height: 271,
      fit: BoxFit.contain,
    );
  }

  Widget _buildOnBoardingPageControl() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: onboardingItem.index == 0
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          Container(
            height: 4,
            width: 26,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: onboardingItem.index == 1
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: onboardingItem.index == 2
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnBoardingTitleAndContent() {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24),
      child: Column(
        spacing: 42,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            onboardingItem.title,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white.withValues(alpha: 0.87),
            ),
          ),

          Text(
            onboardingItem.content,

            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.87),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOnBoardingNextAndPrevButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => onboardingItem.onBackPressed(),
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.44),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8875FF),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () => onboardingItem.onNextPressed(),
            child: Text(
              onboardingItem.index == 2 ? "Get Started" : "Next",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
