import 'package:flutter/foundation.dart';

@immutable
class UserInfo {
  final String userId;
  final String displayName;
  final String? email;

  const UserInfo({
    required this.userId,
    required this.displayName,
    required this.email,
  });
}
