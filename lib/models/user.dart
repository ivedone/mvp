import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String username;
  String get handle => '@' + username;
  const UserModel({
    required this.username,
  });
}
