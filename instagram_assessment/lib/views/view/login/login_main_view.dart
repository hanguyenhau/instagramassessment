import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/constants/views/dimension.dart';
import 'package:instagram_assessment/constants/views/text_messages.dart';
import 'package:instagram_assessment/views/util/view/rich_text_two_part_view.dart';
import 'package:instagram_assessment/views/view/home/home_main_view.dart';
import 'package:instagram_assessment/views/view/login/stateless_widget_view/facebook_button_view.dart';
import 'package:instagram_assessment/views/view/login/stateless_widget_view/google_button_view.dart';
import 'package:instagram_assessment/views/view/login/stateless_widget_view/horizontal_divider_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ),
                        );
                      },
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
