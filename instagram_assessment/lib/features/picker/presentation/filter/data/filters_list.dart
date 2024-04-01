

import 'package:instagram_assessment/features/picker/presentation/filter/model/filter.dart';

class Filters{
  List<Filter> list(){
    return <Filter>[
      Filter(fileName: 'No Filter', matrix:   [1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 0, 1, 0]),
            Filter(fileName: 'Purple', matrix: [1, -0.2, 0, 0, 0,
  0, 1, 0, -0.1, 0,
  0, 1.2, 1, 0.1, 0,
  0, 0, 1.7, 1, 0]),
            Filter(fileName: 'Yellow', matrix:  [1, 0, 0, 0, 0,
  -0.2, 1.0, 0.3, 0.1, 0,
  -0.1, 0, 1, 0, 0,
  0, 0, 0, 1, 0]),
            Filter(fileName: 'Cyan', matrix: [1, 0, 0, 1.9, -2.2,
  0, 1, 0, 0.0, 0.3,
  0, 0, 1, 0, 0.5,
  0, 0, 0, 1, 0.2]),
      Filter(fileName: 'B & W', matrix: [0, 1, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 1, 0, 1, 0]),
   Filter(fileName: 'Old Time', matrix:  [1, 0, 0, 0, 0,
-0.4, 1.3, -0.4, 0.2, -0.1,
  0, 0, 1, 0, 0,
  0, 0, 0, 1, 0]),
   Filter(fileName: 'Cold Life', matrix:   [1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  -0.2, 0.2, 0.1, 0.4, 0,
  0, 0, 0, 1, 0]),
   Filter(fileName: 'Sepium', matrix:  [1.3, -0.3, 1.1, 0, 0,
  0, 1.3, 0.2, 0, 0,
  0, 0, 0.8, 0.2, 0,
  0, 0, 0, 1, 0]),
   Filter(fileName: 'Milk', matrix: [0, 1.0, 0, 0, 0,
  0, 1.0, 0, 0, 0,
  0, 0.6, 1, 0, 0,
  0, 0, 0, 1, 0]),
    ];
  }
}