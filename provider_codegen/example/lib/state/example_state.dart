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
  String get bar => _bar;

  // @StateField()
  // bool get isAwesome => _isAwesome;
}

class Template extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  Template(this.sharedPreferences);

  String get foo => _foo;

  /// Generated code

  /// 1. Create backing value
  String _foo;

  /// 3. Persist data to [SharedPreferences]
  final _fooStorageKey = "ExampleState.foo";

  /// 2. Create the reactive setter
  set foo(String e) {
    _foo = e;

    sharedPreferences.setString(_fooStorageKey, e);
    notifyListeners();
  }

  /// 4. Hydrate data from [SharedPreferences]
  hydrateFields() {
    _foo = sharedPreferences.getString(_fooStorageKey);
  }
}
