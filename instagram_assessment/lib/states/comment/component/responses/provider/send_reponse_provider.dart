import 'package:instagram_assessment/states/comment/component/responses/notifier/send_response_notifier.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';
import 'package:riverpod/riverpod.dart';

final sendResponseProvider =
    StateNotifierProvider<SendResponseNotifier, IsLoading>(
  (ref) => SendResponseNotifier(),
);
