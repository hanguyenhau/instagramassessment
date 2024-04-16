import 'package:flutter/material.dart';
import 'package:instagram_assessment/features/home/presentation/home_main_view.dart';
import 'package:instagram_assessment/features/authentication/presentation/login/login_view.dart';
import 'package:instagram_assessment/features/picker/model/picker_type.dart';
import 'package:instagram_assessment/features/picker/presentation/adjust/adjust_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/blur/blur_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/crop/scrop_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/draw/draw_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/filter/filter_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/fit/fit_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/image_picker_display.dart';
import 'package:instagram_assessment/features/picker/presentation/mask/mask_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/sticker/sticker_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/text/text_screen.dart';
import 'package:instagram_assessment/features/picker/presentation/tint/tint_screen.dart';
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
    '/i/Picker/': (routeData) => const MaterialPage(
          child: ImagePickerDisplay(),
        ),
    '/i/${Picker.crop.name}/': (routeData) => const MaterialPage(
          child: ScropScreen(),
        ),
    '/i/${Picker.filter.name}/': (routeData) => const MaterialPage(
          child: FilterScreen(),
        ),
    '/i/${Picker.adjust.name}/': (routeData) => const MaterialPage(
          child: AdjustScreen(),
        ),
    '/i/${Picker.fit.name}/': (routeData) => const MaterialPage(
          child: FitScreen(),
        ),
    '/i/${Picker.tint.name}/': (routeData) => const MaterialPage(
          child: TintScreen(),
        ),
    '/i/${Picker.blur.name}/': (routeData) => const MaterialPage(
          child: BlurScreen(),
        ),
    '/i/${Picker.sticker.name}/': (routeData) => const MaterialPage(
          child: StickerScreen(),
        ),
    '/i/${Picker.text.name}/': (routeData) => const MaterialPage(
          child: TextScreen(),
        ),
    '/i/${Picker.draw.name}/': (routeData) => const MaterialPage(
          child: DrawScreen(),
        ),
    '/i/${Picker.mask.name}/': (routeData) => const MaterialPage(
          child: MaskScreen(),
        ),
  },
);
