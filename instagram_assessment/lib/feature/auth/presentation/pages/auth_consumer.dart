import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/is_logged_in_provider.dart';
import 'package:instagram_assessment/states/providers/is_loading_provider.dart';
import 'package:instagram_assessment/views/components/loading/loading_screen.dart';
import 'package:instagram_assessment/views/view/home/home_main_view.dart';
import 'package:instagram_assessment/views/view/login/login_main_view.dart';

class AuthConsumer extends StatelessWidget {
  const AuthConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.listen<bool>(
          isLoadingProvider,
          (previous, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          },
        );

        final isLoggedIn = ref.watch(isLoggedInProvider);
        return isLoggedIn ? const HomePage() : const SignInView();
      },
    );
  }
}
