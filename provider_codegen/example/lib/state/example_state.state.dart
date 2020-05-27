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

  bool _bar;
  final _barStorageKey = "ExampleState.bar";
  set bar(bool e) {
    _bar = e;
    sharedPreferences.setBool(_barStorageKey, e);
    notifyListeners();
  }

  double _baz;
  final _bazStorageKey = "ExampleState.baz";
  set baz(double e) {
    _baz = e;
    sharedPreferences.setDouble(_bazStorageKey, e);
    notifyListeners();
  }

  int _friends;
  final _friendsStorageKey = "ExampleState.friends";
  set friends(int e) {
    _friends = e;
    sharedPreferences.setInt(_friendsStorageKey, e);
    notifyListeners();
  }

  List<String> _list;
  final _listStorageKey = "ExampleState.list";
  set list(List<String> e) {
    _list = e;
    sharedPreferences.setStringList(_listStorageKey, e);
    notifyListeners();
  }

  Json _json;
  final _jsonStorageKey = "ExampleState.json";
  set json(Json e) {
    _json = e;
    sharedPreferences.setString(_jsonStorageKey, jsonEncode(e.toJson()));
    notifyListeners();
  }

  hydrateFields() {
    _foo = sharedPreferences.getString(_fooStorageKey);
    _bar = sharedPreferences.getBool(_barStorageKey);
    _baz = sharedPreferences.getDouble(_bazStorageKey);
    _friends = sharedPreferences.getInt(_friendsStorageKey);
    _list = sharedPreferences.getStringList(_listStorageKey);
    _json =
        Json.fromJson(jsonDecode(sharedPreferences.getString(_jsonStorageKey)));
    notifyListeners();
  }
}
