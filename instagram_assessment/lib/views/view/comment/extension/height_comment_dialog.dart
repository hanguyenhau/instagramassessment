import 'package:instagram_assessment/views/view/comment/extension/dialog_height_constant.dart';

extension GetHeightCommentDialog on num {
  double getHeightCommentDialog() {
    switch (this) {
      case 1:
        return DialogHeightConstant.dialog0dot1;
      case 2:
        return DialogHeightConstant.dialog0dot2;
      case 3:
        return DialogHeightConstant.dialog0dot3;
      case >= DialogHeightConstant.dialog0dot4:
        return 0.4;
      default:
        return 0.4;
    }
  }
}
