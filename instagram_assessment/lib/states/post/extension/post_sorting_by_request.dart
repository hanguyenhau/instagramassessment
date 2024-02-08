import 'package:instagram_assessment/states/comment/models/enum/date_sorting.dart';
import 'package:instagram_assessment/states/post/models/post.dart';

extension PostSortingByRequest on Iterable<Post> {
  Iterable<Post> applySortingPostFrom(DateSorting request) {
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
