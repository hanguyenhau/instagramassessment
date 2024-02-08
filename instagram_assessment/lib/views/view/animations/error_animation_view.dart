import 'package:instagram_assessment/views/view/animations/lottie_animation_view.dart';
import 'package:instagram_assessment/views/view/animations/model/animation_lottie.dart';

class ErrorAnimationView extends LottieAnimationView {
  const ErrorAnimationView({super.key})
      : super(
          animation: LottieAnimation.error,
        );
}
