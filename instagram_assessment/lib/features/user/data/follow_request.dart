import 'package:flutter/material.dart';
import 'package:instagram_assessment/models/user.dart';

@immutable
class FollowRequest {
  final UserModel uTarget;
  final UserModel uCurrent;

  const FollowRequest({required this.uTarget, required this.uCurrent});
}
