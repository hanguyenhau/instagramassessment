import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';

class SendResponseNotifier extends StateNotifier<IsLoading> {
  SendResponseNotifier() : super(false);

  set isLoading(bool value) => state = value;

  
}
