import 'package:flutter/material.dart';

@immutable
class User {
  final String username;
  String get handle => '@$username';
  final String? imageUrl;
  const User({
    required this.username,
    this.imageUrl,
  });
}
