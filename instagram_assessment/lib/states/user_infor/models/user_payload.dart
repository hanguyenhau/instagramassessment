import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

@immutable
class UserPayLoad extends MapView<String, String> {
  UserPayLoad({
    required String userId,
    required String? displayName,
    required String? email,
    required String? image
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName ?? '',
          FirebaseFieldName.email: email ?? '',
          FirebaseFieldName.image: image ?? '',
        });  
}
