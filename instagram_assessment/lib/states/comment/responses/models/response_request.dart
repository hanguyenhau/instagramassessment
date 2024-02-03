import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/responses/models/response.dart';

@immutable
class ResponseRequest {
  final Response response;
  final Comment comment;

  const ResponseRequest({
    required this.response,
    required this.comment,
  });
}
