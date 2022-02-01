import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/models/repos/local_routines.dart';
import 'package:mvp/models/repos/users.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/user.dart';

abstract class Profile with ChangeNotifier {
  User get user;
  List<Routine> myRoutines();
}

class LocalProfile extends Profile {
  @override
  User get user => fakeUser();

  final LocalRoutines _localRoutines = GetIt.I<LocalRoutines>();
  @override
  List<Routine> myRoutines() => _localRoutines.getAll();
}
