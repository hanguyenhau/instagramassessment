import 'package:flutter/material.dart';
import 'package:instagram_assessment/features/home/presentation/home_main_view.dart';
import 'package:instagram_assessment/features/authentication/presentation/login/login_view.dart';
import 'package:instagram_assessment/features/picker/presentation/adjust/adjust_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/crop/scrop_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/filter/filter_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/image_picker_display.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/user_detail_views.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginView()),
});

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: HomePage()),
    '/u/:uid/': (routeData) => MaterialPage(
          child: UserDetailsView(userId: routeData.pathParameters['uid']!),
        ),
    '/i/picker/': (routeData) => const MaterialPage(
          child: ImagePickerDisplay(),
        ),
    '/i/crop/': (routeData) => const MaterialPage(
          child: ScropScreen(),
        ),
    '/i/filter/': (routeData) => const MaterialPage(
          child: FilterScreen(),
        ),
    '/i/adjust/': (routeData) => const MaterialPage(
          child: AdjustScreen(),
        ),
  },
);
