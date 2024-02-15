import 'package:instagram_assessment/feature/dio/models/user.dart';
// 1. import the riverpod_annotation package
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 2. add a part file
part 'new_user_provider.g.dart';

// 3. use the @riverpod annotation
@riverpod
// 4. update the declaration
User user(UserRef ref) {
  return User();
}
