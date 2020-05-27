// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_state.dart';

// **************************************************************************
// StateGenerator
// **************************************************************************

class _$ExampleStateChangeNotifier extends ChangeNotifier {
  _$ExampleStateChangeNotifier(this.sharedPreferences);
  final SharedPreferences sharedPreferences;
  String _foo;
  final _fooStorageKey = "ExampleState.foo";
  set foo(String e) {
    _foo = e;
    sharedPreferences.setString(_fooStorageKey, e);
    notifyListeners();
  }
}
