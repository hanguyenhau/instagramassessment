import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/feature/dio/models/user.dart';

final dioProvider = Provider<User>((ref) {
  return User();
});
