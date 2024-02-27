import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/features/comment/data/model/date_sorting.dart';

extension CommentSortingByRequest on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(DateSorting request) {
    final sortedDocument = toList()
      ..sort(
        (a, b) {
          switch (request) {
            case DateSorting.newestOnTop:
              return b.createAt.compareTo(a.createAt);

            case DateSorting.oldestOnTop:
              return a.createAt.compareTo(b.createAt);
          }
        },
      );
    return sortedDocument;
  }
}
