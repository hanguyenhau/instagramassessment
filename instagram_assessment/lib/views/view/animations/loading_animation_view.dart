import 'package:instagram_assessment/views/view/animations/lottie_animation_view.dart';
import 'package:instagram_assessment/views/view/animations/model/animation_lottie.dart';

class LoadingAnimationView extends LottieAnimationView {
  const LoadingAnimationView({super.key})
      : super(
          animation: LottieAnimation.loading,
        );
}
