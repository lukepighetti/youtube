// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_state.dart';

// **************************************************************************
// StateGenerator
// **************************************************************************

class _$ExampleStateChangeNotifier extends ChangeNotifier {
  _$ExampleStateChangeNotifier(this.sharedPreferences) {
    hydrateFields();
  }
  final SharedPreferences sharedPreferences;
  String _foo;
  final _fooStorageKey = "ExampleState.foo";
  set foo(String e) {
    _foo = e;
    sharedPreferences.setString(_fooStorageKey, e);
    notifyListeners();
  }

  String _bar;
  final _barStorageKey = "ExampleState.bar";
  set bar(String e) {
    _bar = e;
    sharedPreferences.setString(_barStorageKey, e);
    notifyListeners();
  }

  hydrateFields() {
    _foo = sharedPreferences.getString(_fooStorageKey);
    _bar = sharedPreferences.getString(_barStorageKey);
  }
}
