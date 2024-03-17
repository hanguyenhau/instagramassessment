import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/common/error_text.dart';
import 'package:instagram_assessment/config/core/common/loader.dart';
import 'package:instagram_assessment/config/theme/behavior/app_scroll_behavior.dart';
import 'package:instagram_assessment/config/theme/app_themes.dart';
import 'package:instagram_assessment/features/authentication/controller/auth_controller.dart';
import 'package:instagram_assessment/firebase_options.dart';
import 'package:instagram_assessment/route.dart';
import 'package:routemaster/routemaster.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            return MaterialApp.router(
              theme: theme(),
              debugShowCheckedModeBanner: false,
              scrollBehavior: scrollBehavior(),
              routerDelegate: RoutemasterDelegate(
                routesBuilder: (context) {
                  if (data != null) {
                    return loggedInRoute;
                  }
                  return loggedOutRoute;
                },
              ),
              routeInformationParser: const RoutemasterParser(),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
