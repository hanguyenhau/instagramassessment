import 'package:flutter/foundation.dart';

typedef CloseLoadingScreen = Function();
typedef UpdateLoadingScreen = Function(String text);

@immutable
class LoadingScreenModel{
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenModel({
    required this.close,
    required this.update,
  });
}
