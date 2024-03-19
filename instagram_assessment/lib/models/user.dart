import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';

@immutable
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final String? documentId;

  const UserModel({
    required this.image,
    required this.uid,
    required this.name,
    required this.email,
    this.documentId,
  });

  UserModel coppyWith({
    String? uid,
    String? name,
    String? email,
    String? image,
  }) {
    return UserModel(
      image: image ?? this.image,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  factory UserModel.fromJson({required Map<String, dynamic> json, required String documentId}) => UserModel(
        uid: json[FirebaseFieldName.userId],
        name: json[FirebaseFieldName.displayName] ?? '',
        email: json[FirebaseFieldName.email],
        image: json[FirebaseFieldName.image],
        documentId: documentId,
      );

  Map<String, dynamic> toJson() => {
        FirebaseFieldName.userId: uid,
        FirebaseFieldName.name: name,
        FirebaseFieldName.email: email,
        FirebaseFieldName.image: image,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          email == other.email &&
          image == other.image;

  @override
  int get hashCode => Object.hashAll([
        uid,
        name,
        email,
        image,
      ]);
}

