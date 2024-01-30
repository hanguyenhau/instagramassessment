import 'package:flutter/foundation.dart';

@immutable 
class FirebaseCollectionName {
  static const users = 'users';
  static const thumbnails = 'thumbnails';
  static const posts = 'posts';
  static const likes = 'likes';

  const FirebaseCollectionName._();
}