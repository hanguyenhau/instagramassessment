import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
import 'package:instagram_assessment/config/core/providers/firebase_provider.dart';
import 'package:instagram_assessment/models/like.dart';
import 'package:instagram_assessment/models/like_payload.dart';
import 'package:instagram_assessment/models/post.dart';
import 'package:instagram_assessment/models/post_payload.dart';
import 'package:instagram_assessment/models/typedef.dart';

final postStorageProvider = Provider(
  (ref) => PostStorage(
    firestore: ref.read(firestoreProvider),
  ),
);

@immutable
class PostStorage {
  final FirebaseFirestore _firestore;

  const PostStorage({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _post =>
      _firestore.collection(FirebaseCollectionName.posts);
  CollectionReference get _like =>
      _firestore.collection(FirebaseCollectionName.likes);

  Stream<Iterable<Post>> allPosts() => _post
      .orderBy(FirebaseFieldName.createAt, descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map(
            (doc) => Post(
              postId: doc.id,
              json: doc.data() as Map<String, dynamic>,
            ),
          ));

  Stream<Iterable<Post>> retrieveUserPost({required UserId userId}) => _post
      .where(FirebaseFieldName.userId, isEqualTo: userId)
      .snapshots()
      .map((snapshot) => snapshot.docs.map(
            (doc) => Post(
              postId: doc.id,
              json: doc.data() as Map<String, dynamic>,
            ),
          ));

  Future<void> savePost(PostPayLoad payLoad) async => await _post.add(payLoad);

  Stream<Iterable<Like>> allLikePost(PostId postId) => _like
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Like(
            json: doc.data() as Map<String, dynamic>,
          )));

  Stream<bool> hasLike({required PostId postId, required UserId userId}) {
    return _like
        .where(FirebaseFieldName.postId, isEqualTo: postId)
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }

  Future<void> likePost(LikePayLoad payload) async =>
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.likes)
          .add(payload);

  Future<void> dislikePost(
          {required PostId postId, required UserId userId}) async =>
      _like
          .where(FirebaseFieldName.postId, isEqualTo: postId)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .get()
          .then((snapshot) async {
        for (final doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
}
