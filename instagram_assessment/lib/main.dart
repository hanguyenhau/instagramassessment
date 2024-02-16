import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/theme/behavior/app_scroll_behavior.dart';
import 'package:instagram_assessment/config/theme/app_themes.dart';
import 'package:instagram_assessment/features/authentication/presentation/test.dart';
import 'package:instagram_assessment/firebase_options.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: false,
      scrollBehavior: scrollBehavior(),
      home: const UserListScreen(),
    );
  }
}


