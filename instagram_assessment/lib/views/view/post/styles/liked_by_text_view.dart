import 'package:flutter/material.dart';
import 'package:instagram_assessment/states/like/models/total_like_request.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';

class LikedByTextView extends StatelessWidget {
  final TotalLikeRequest totalLikeRequest;
  const LikedByTextView({super.key, required this.totalLikeRequest});

  @override
  Widget build(BuildContext context) {
    final likeRemaining = totalLikeRequest.totalLike - 1;
    return RichText(
        textAlign: TextAlign.left,
        text: TextSpan(children: [
          TextSpan(
            text: TextMessage.likedBy,
            style: TextStyle(color: AppColor.callToActionText),
          ),
          TextSpan(
            text: ' ${totalLikeRequest.likedBy}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          likeRemaining > 0
              ? TextSpan(
                  text: ' ${TextMessage.and}',
                  style: TextStyle(color: AppColor.callToActionText),
                )
              : const TextSpan(),
          likeRemaining > 0
              ? TextSpan(
                  text: ' $likeRemaining ${TextMessage.others}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              : const TextSpan(),
        ]));
  }
}
