import 'package:flutter/foundation.dart';

@immutable 
class FirebaseFieldName{
  static const userId = 'uid';
  static const displayName = 'display_name';
  static const credentialId = 'creadential_id';
  static const name = 'name';
  static const email = 'email';
  static const createAt = 'created_at';
  static const image = 'image';
  static const postId = 'post_id';
  static const comment = 'comment';
  static const commentId = 'comment_id';
  static const likes = 'likes';
  static const responses = 'responses';
  static const following = 'following';
  static const followers = 'followers';

  const FirebaseFieldName._();
}