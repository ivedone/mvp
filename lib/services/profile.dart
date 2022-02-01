import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/models/repos/local_routines.dart';
import 'package:mvp/models/routine.dart';

abstract class Profile with ChangeNotifier {
  List<Routine> getAll();
}

class FakeProfile extends Profile {
  final LocalRoutines _localRoutines = GetIt.I<LocalRoutines>();
  @override
  List<Routine> getAll() => _localRoutines.getAll();
}
