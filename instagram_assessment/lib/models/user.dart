import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';

@immutable
class UserModel {
  final String userId;
  final String displayName;
  final String email;
  final String image;

  const UserModel({
    required this.image,
    required this.userId,
    required this.displayName,
    required this.email,
  });

  UserModel coppyWith({
    String? userId,
    String? displayName,
    String? email,
    String? image,
  }) {
    return UserModel(
      image: image ?? this.image,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
    );
  }

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      userId: json[FirebaseFieldName.userId],
      displayName: json[FirebaseFieldName.displayName] ?? '',
      email: json[FirebaseFieldName.email],
      image: json[FirebaseFieldName.image],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email &&
          image == other.image;

  @override
  int get hashCode => Object.hashAll([
        userId,
        displayName,
        email,
        image,
      ]);
}
