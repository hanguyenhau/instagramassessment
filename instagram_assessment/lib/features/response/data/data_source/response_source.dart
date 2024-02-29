import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
import 'package:instagram_assessment/config/core/providers/firebase_provider.dart';
import 'package:instagram_assessment/features/response/data/model/like_response_request.dart';
import 'package:instagram_assessment/models/response.dart';
import 'package:instagram_assessment/models/response_payload.dart';
import 'package:instagram_assessment/models/typedef.dart';

final responseStorageProvider = Provider(
  (ref) => ResponseStorage(
    firestore: ref.read(firestoreProvider),
  ),
);

@immutable
class ResponseStorage {
  final FirebaseFirestore _firestore;

  const ResponseStorage({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _comment =>
      _firestore.collection(FirebaseCollectionName.comments);

  Future<bool> createResponse(
      {required ResponsePayLoad response, required CommentId commentId}) async {
    try {
      _comment
          .doc(commentId)
          .collection(FirebaseFieldName.responses)
          .add(response);
      return true;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (_) {
      return false;
    }
  }

  Stream<Iterable<Response>> allResponses(CommentId commentId) {
    try {
      return _comment
          .doc(commentId)
          .collection(FirebaseFieldName.responses)
          .orderBy(FirebaseFieldName.createAt, descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map(
                (doc) => Response.fromJson(
                  json: doc.data(),
                  responseId: doc.id,
                ),
              ));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateLike(
      {required LikeResponseRequest request,
      required Iterable<dynamic> likes}) async {
    try {
      final query = await _comment
          .doc(request.commentId)
          .collection(FirebaseFieldName.responses)
          .doc(request.response.responseId)
          .get();

      if (!query.exists) {
        return false;
      }
      //update all likes
      await query.reference.update({
        FirebaseFieldName.likes: likes,
        // You can add more fields to update here if needed
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
