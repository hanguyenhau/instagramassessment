
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';

extension GetCollectionFileTypeName on FileType {
  String getCollectionFileTypeName() {
    switch (this) {
      case FileType.image:
        return TextMessage.image;

      case FileType.video:
        return TextMessage.video;
    }
  }
}
