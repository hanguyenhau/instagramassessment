import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/backend/provider/auth_state_provider.dart';
import 'package:instagram_assessment/models/typedef.dart';

final userIdProvider = Provider<UserId?>(
  (ref) => ref.watch(authStateProvider).userid,
);
