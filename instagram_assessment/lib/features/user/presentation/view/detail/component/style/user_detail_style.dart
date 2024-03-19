import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/config/views/view/elevated_button_view.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/component/style/user_detail_child_style.dart';

@immutable
class UserDetailStyle {
  static get followButton => Container(
      padding: UserDetailChildStyles.buttonPadding,
      decoration:
          UserDetailChildStyles.buttonDecoration(AppColor.facebookColor),
      child: UserDetailChildStyles.textButton(TextMessage.follow));

  static get editButton => Container(
      padding: UserDetailChildStyles.buttonPadding,
      decoration:
          UserDetailChildStyles.buttonDecoration(AppColor.facebookColor),
      child: UserDetailChildStyles.textButton(TextMessage.editProfile));

  static get messageButton => Container(
      padding: UserDetailChildStyles.buttonPadding,
      decoration:
          UserDetailChildStyles.buttonDecoration(AppColor.callToActionButton),
      child: UserDetailChildStyles.textButton(
        TextMessage.message,
      ));

  static get addFollowButton => Container(
        padding: const EdgeInsets.all(5),
        decoration: UserDetailChildStyles.iconContainer,
        child: const ElevatedButtonView(
          iconName: AssetsPath.addFriendButton,
        ),
      );
}
