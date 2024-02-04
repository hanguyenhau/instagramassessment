import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/responses/models/response_payload.dart';
import 'package:instagram_assessment/states/comment/responses/models/response_request.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';

class SendResponseNotifier extends StateNotifier<IsLoading> {
  SendResponseNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> sendResponse({
    required ResponseRequest request,
  }) async {
    isLoading = true;

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .doc(request.comment.commentId)
          .collection(FirebaseFieldName.responses)
          .add(
            ResponsePayLoad(
                comment: request.response.comment,
                userId: request.response.userId),
          );

      isLoading = false;
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
