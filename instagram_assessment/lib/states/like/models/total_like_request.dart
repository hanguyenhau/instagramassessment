import 'package:flutter/foundation.dart';

@immutable
class TotalLikeRequest {
  final String likedBy;
  final int totalLike;

  const TotalLikeRequest({
    required this.likedBy,
    required this.totalLike,
  });
}
