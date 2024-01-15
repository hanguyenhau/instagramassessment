import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/constants/views/dimension.dart';
import 'package:instagram_assessment/constants/views/text_messages.dart';
import 'package:instagram_assessment/states/provider/auth_state_provider.dart';
import 'package:instagram_assessment/views/util/view/rich_text_two_part_view.dart';
import 'package:instagram_assessment/views/view/login/stateless_widget_view/facebook_button_view.dart';
import 'package:instagram_assessment/views/view/login/stateless_widget_view/google_button_view.dart';
import 'package:instagram_assessment/views/view/login/stateless_widget_view/horizontal_divider_view.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(Dimension.padding16),
                child: Column(
                  children: [
                    Image.asset(
                      AssetsPath.instagram,
                    ),
                    const SizedBox(
                      height: Dimension.height15,
                    ),
                    Text(
                      TextMessage.signInToSee,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            height: Dimension.height1dot5,
                          ),
                    ),
                    const SizedBox(
                      height: Dimension.height120,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: AppColor.facebookColor,
                        foregroundColor: AppColor.whiteColor,
                      ),
                      child: const FacebookButtonView(),
                    ),
                    const HorizontalDevider(
                      padding: Dimension.height30,
                      containOr: true,
                    ),
                    TextButton(
                      onPressed:
                          ref.read(authStateProvider.notifier).loginWithGoogle,
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return const HomePage();
                      //     },
                      //   ),
                      // );

                      style: TextButton.styleFrom(
                          backgroundColor: AppColor.whiteColor,
                          foregroundColor: AppColor.facebookColor,
                          side: BorderSide(
                            color: AppColor.facebookColor,
                            width: 1,
                          )),
                      child: const GoogleButtonView(),
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: const Align(
        alignment: Alignment.bottomCenter,
        child: RichTwoPartTextView(
          leftPart: TextMessage.alreadyHaveAccount,
          rightPart: TextMessage.signIn,
        ),
      ),
    );
  }
}
