import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/loading/controller/is_loading_provider.dart';
import 'package:instagram_assessment/features/loading/presentation/loading_screen.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/home/presentation/home_main_view.dart';
import 'package:instagram_assessment/features/authentication/presentation/login/login_view.dart';

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

        final isLoggedIn = ref.watch(userProvider) != null;
        return isLoggedIn ? const HomePage() : const LoginView();
      },
    );
  }
}
