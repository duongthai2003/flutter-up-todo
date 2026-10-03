enum OnboardingPagePosition { page1, page2, page3 }

extension OnboardingPagePositionExtension on OnboardingPagePosition {
  String onBoardingPageImage() {
    /**
 -- tương tự như
      if (this == OnboardingPagePosition.page1) {
      return "assets/images/onBoarding_1.png";
    }
    if (this == OnboardingPagePosition.page2) {
      return "assets/images/onBoarding_2.png";
    }
    if (this == OnboardingPagePosition.page3) {
      return "assets/images/onBoarding_3.png";
    }
**/

    switch (this) {
      case OnboardingPagePosition.page1:
        return "assets/images/onBoarding_1.png";
      case OnboardingPagePosition.page2:
        return "assets/images/onBoarding_2.png";
      case OnboardingPagePosition.page3:
        return "assets/images/onBoarding_3.png";
    }
  }

  String onBoardingPageTitle() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return "Manage your tasks";
      case OnboardingPagePosition.page2:
        return "Create daily routine";
      case OnboardingPagePosition.page3:
        return "Orgonaize your tasks";
    }
  }

  String onBoardingPageContent() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return "You can easily manage all of your daily tasks in DoMe for free";
      case OnboardingPagePosition.page2:
        return "In Uptodo  you can create your personalized routine to stay productive";
      case OnboardingPagePosition.page3:
        return "You can organize your daily tasks by adding your tasks into separate categories";
    }
  }
}
