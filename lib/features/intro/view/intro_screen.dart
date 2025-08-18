import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/routing/app_routes_fun.dart';
import '../../../app/routing/routes.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../generated/assets.gen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  List<PageViewModel> getPages(BuildContext context) => [
        PageViewModel(
          title: LocaleKeys.onboardinTitle1.tr(),
          body: LocaleKeys.onboardingDescription1.tr(),
          image: Center(
            child: Image.asset(
              Assets.images.logo.path,
              height: 200.0,
            ),
          ),
          decoration: _pageDecoration(),
        ),
        PageViewModel(
          title: LocaleKeys.onboardinTitle2.tr(),
          body: LocaleKeys.onboardingDescription2.tr(),
          decoration: _pageDecoration(),
          backgroundImage: Assets.images.onboarding2.path,
        ),
        PageViewModel(
          title: LocaleKeys.onboardinTitle3.tr(),
          body: LocaleKeys.onboardingDescription3.tr(),
          decoration: _pageDecoration(),
          backgroundImage: Assets.images.onboarding3.path,
        ),
      ];

  // Define page decoration for consistent styling
  PageDecoration _pageDecoration() => const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white70,
        ),
        imagePadding: EdgeInsets.only(top: 40),
        pageColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: IntroductionScreen(
            pages: getPages(context),
            onDone: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('firstTime', false);
              replacement(NamedRoutes.i.layout);
            },
            showSkipButton: true,
            skip: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            next: const Icon(Icons.arrow_forward, color: Colors.white),
            done: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            dotsDecorator: const DotsDecorator(
              activeColor: Colors.white,
              size: Size(10.0, 10.0),
              color: Colors.white54,
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            globalBackgroundColor: Colors.transparent,
          ),
        ),
      );
}
