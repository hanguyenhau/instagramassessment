import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/view/animations/lottie_animation_view.dart';
import 'package:instagram_assessment/views/view/animations/model/animation_lottie.dart';

class DataNotFoundAnimationView extends LottieAnimationView {
  const DataNotFoundAnimationView({super.key})
      : super(animation: LottieAnimation.dataNotFound);
}
