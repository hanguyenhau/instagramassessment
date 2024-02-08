import 'package:instagram_assessment/states/comment/component/responses/models/response.dart';
import 'package:instagram_assessment/states/comment/models/enum/date_sorting.dart';

extension ResponseSortingByRequest on Iterable<Response> {
  Iterable<Response> applySortingResponseFrom(DateSorting request) {
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
