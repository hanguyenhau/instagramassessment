import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

@immutable
class LikeRequest {
  final PostId postId;
  final UserId likedBy;

  const LikeRequest({required this.postId, required this.likedBy});
}
