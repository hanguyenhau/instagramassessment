
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';

extension GetCollectionFileTypeName on FileType {
  String getCollectionFileTypeName() {
    switch (this) {
      case FileType.image:
        return 'image';

      case FileType.video:
        return 'video';
    }
  }
}
