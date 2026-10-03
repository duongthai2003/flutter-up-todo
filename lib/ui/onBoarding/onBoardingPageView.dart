// class cha: quản lý các page con. di chuyển qua lại giữa các page con.

import 'package:fluter_app/ui/onBoarding/onBoardingChildPage.dart';
import 'package:flutter/material.dart';
import 'package:fluter_app/ultils.emuns/OnboardingPagePosition.dart';

class OnBoardingPageView extends StatefulWidget {
  const OnBoardingPageView({super.key});
  @override
  State<OnBoardingPageView> createState() => _OnBoardingPageViewState();
}

class _OnBoardingPageViewState extends State<OnBoardingPageView> {
  final _pageController = PageController();
  List<OnboardingItemType> _onBoardingContent() {
    return [
      (
        index: 0,
        title: "Manage your tasks",
        content:
            "You can easily manage all of your daily tasks in DoMe for free",
        image: "assets/images/onBoarding_1.png",
        onBackPressed: () {},
        onNextPressed: () => _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        // _pageController.jumpToPage(1) // chuyển trang một cách đột ngột
      ),
      (
        index: 1,
        title: "Create daily routine",
        content: "In Uptodo  you can create your personalized routine to stay productive",
        image: "assets/images/onBoarding_2.png",
        onBackPressed: () => _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        onNextPressed: () => _pageController.animateToPage(
          2,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      ),
      (
        index: 2,
        title: "Orgonaize your tasks",
        content: "You can organize your daily tasks by adding your tasks into separate categories",
        image: "assets/images/onBoarding_3.png",
        onBackPressed: () => _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        onNextPressed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController, // controller để quản lý pageView slide
        physics: NeverScrollableScrollPhysics(), // không cho cuộn bằng tay
        // children: [
        //   // OnBoardingChildPage(
        //   //   onboardingPagePosition: OnboardingPagePosition.page1,
        //   //   onNextPressed: () => {
        //   //     // _pageController.jumpToPage(1) // chuyển trang một cách đột ngột
        //   //     _pageController.animateToPage(
        //   //       1,
        //   //       duration: const Duration(milliseconds: 300),
        //   //       curve: Curves.easeInOut,
        //   //     ), // chuyển trang một cách mượt có hiệu ứng
        //   //   },
        //   //   onBackPressed: () => {print("page 1")},
        //   // ),
        //   // OnBoardingChildPage(
        //   //   onboardingPagePosition: OnboardingPagePosition.page2,
        //   //   onNextPressed: () => {
        //   //     _pageController.animateToPage(
        //   //       2,
        //   //       duration: const Duration(milliseconds: 300),
        //   //       curve: Curves.easeInOut,
        //   //     ),
        //   //   },
        //   //   onBackPressed: () => {
        //   //     _pageController.animateToPage(
        //   //       0,
        //   //       duration: const Duration(milliseconds: 300),
        //   //       curve: Curves.easeInOut,
        //   //     ),
        //   //   },
        //   // ),
        //   // OnBoardingChildPage(
        //   //   onboardingPagePosition:
        // ],

        //  truyền vào các widget con mà muốn pageView hiển thị.
        children: _onBoardingContent().map((item) {
          return OnBoardingChildPage(onboardingItem: item);
        }).toList(),
      ),
    );
  }
}
