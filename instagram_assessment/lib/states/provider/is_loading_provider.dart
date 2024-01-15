import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/provider/auth_state_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.isLoading;
});