import 'package:flutter/material.dart';

@immutable
class User {
  final String username;
  String get handle => '@$username';
  const User({
    required this.username,
  });
}
