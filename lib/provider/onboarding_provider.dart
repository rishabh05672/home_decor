import 'package:decoze/model/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final List<OnboardingModel> _onboardingScreens = [
    OnboardingModel(
      image: "assets/images/onboarding1.png",
      title: "Effortlessly organize your decor \nand shopping with decoze",
      description:
          "Confidently navigate your decor journey, ensuring a \nstylish and productive path to your dream space \nwith decoze",
    ),
    OnboardingModel(
      image: "assets/images/onboarding2.png",
      title: "Stay connected with design team anytime, \nanywhere with decoze",
      description:
          "In today's dynamic decor world, staying connected with \nyour design team is key to success with \ndecoze.",
    ),
    OnboardingModel(
      image: "assets/images/onboarding3.png",
      title: "Discover all the features \ndecoze has to offer",
      description:
          "Dive into decoze's multitude of features \nby exploring its diverse functionalities.",
    ),
  ];

  List<OnboardingModel> get onboardingScreens => _onboardingScreens;
}
