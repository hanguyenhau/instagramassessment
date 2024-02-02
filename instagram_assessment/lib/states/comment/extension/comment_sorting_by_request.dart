import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/models/comment_post_request.dart';
import 'package:instagram_assessment/states/comment/models/date_sorting.dart';

extension CommentSortingByRequest on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(CommentPostRequest request) {
    if (request.sortByCreateAt) {
      final sortedDocument = toList()
        ..sort(
          (a, b) {
            switch (request.dateSorting) {
              case DateSorting.newestOnTop:
                return b.createAt.compareTo(a.createAt);

              case DateSorting.oldestOnTop:
                return a.createAt.compareTo(b.createAt);
            }
          },
        );
      return sortedDocument;
    } else {
      return this;
    }
  }
}
