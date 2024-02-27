import 'package:instagram_assessment/config/core/animations/lottie_animation_view.dart';
import 'package:instagram_assessment/config/core/animations/model/animation_lottie.dart';

class ErrorAnimationView extends LottieAnimationView {
  const ErrorAnimationView({super.key})
      : super(
          animation: LottieAnimation.error,
        );
}
