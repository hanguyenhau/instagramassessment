import 'dart:ui';

import 'package:flutter/material.dart';

dynamic scrollBehavior() {
  return const MaterialScrollBehavior().copyWith(
    dragDevices: {
      PointerDeviceKind.mouse,
      PointerDeviceKind.touch,
      PointerDeviceKind.stylus,
      PointerDeviceKind.unknown
    },
  );
}
