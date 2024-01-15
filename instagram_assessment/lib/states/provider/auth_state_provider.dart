import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/models/auth_state.dart';
import 'package:instagram_assessment/states/notifier/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());
