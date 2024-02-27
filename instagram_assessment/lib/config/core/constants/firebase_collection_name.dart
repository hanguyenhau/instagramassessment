import 'package:flutter/foundation.dart';

@immutable 
class FirebaseCollectionName {
  static const users = 'users';
  static const thumbnails = 'thumbnails';
  static const posts = 'posts';
  static const likes = 'likes';
  static const comments = 'comments';

  const FirebaseCollectionName._();
}