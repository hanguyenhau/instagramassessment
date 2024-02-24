import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

@immutable
class LikeRequest {
  final PostId postId;
  final UserId likedBy;

  const LikeRequest({
    required this.postId,
    required this.likedBy,
  });
}
