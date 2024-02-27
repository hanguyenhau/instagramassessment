import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
import 'package:instagram_assessment/config/core/providers/firebase_provider.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/models/comment_payload.dart';
import 'package:instagram_assessment/models/typedef.dart';

final commentStorageProvider = Provider(
  (ref) => CommentStorage(
    firestore: ref.read(firestoreProvider),
  ),
);

@immutable
class CommentStorage {
  final FirebaseFirestore _firestore;

  const CommentStorage({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _comment =>
      _firestore.collection(FirebaseCollectionName.comments);

  Future<bool> createComment(CommentPayLoad comment) async {
    try {
      _firestore.collection(FirebaseCollectionName.comments).add(comment);
      return true;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (_) {
      return false;
    }
  }

  Stream<Iterable<Comment>> allComments(PostId postId) {
    try {
      return _comment
          .where(FirebaseFieldName.postId, isEqualTo: postId)
          .orderBy(FirebaseFieldName.createAt, descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map(
                (doc) => Comment.fromJson(
                  json: doc.data() as Map<dynamic, dynamic>,
                  commentId: doc.id,
                ),
              ));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      rethrow;
    }
  }

  Stream<Comment> commentById(CommentId commentId) {
    try {
      return _comment
          .where(FieldPath.documentId, isEqualTo: commentId)
          .limit(1)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Comment.fromJson(
                    commentId: doc.id,
                    json: doc.data() as Map<dynamic, dynamic>,
                  ))
              .first);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      rethrow;
    }
  }
}
