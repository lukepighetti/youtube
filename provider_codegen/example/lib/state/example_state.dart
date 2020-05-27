import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:state_annotation/state_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'example_state.state.dart';

@StateClass()
class ExampleState extends _$ExampleStateChangeNotifier {
  ExampleState(SharedPreferences sharedPreferences) : super(sharedPreferences);

  @StateField()
  String get foo => _foo;

  @StateField()
  bool get bar => _bar;

  @StateField()
  double get baz => _baz;

  @StateField()
  int get friends => _friends;

  @StateField()
  List<String> get list => _list;

  @StateField()
  Json get json => _json;
}

class Json {
  Json.fromJson(Map<String, dynamic> e);

  Map<String, dynamic> toJson() => {};
}
