import 'package:flutter/foundation.dart';
import 'package:state_annotation/state_annotation.dart';

part 'example_state.state.dart';

@StateClass()
class ExampleState extends _$ExampleStateChangeNotifier {
  @StateField()
  String get foo => _foo;

  @StateField()
  bool get isAwesome => _isAwesome;
}

class Template extends ChangeNotifier {
  String get foo => _foo;

  /// Generated code

  /// 1. Create backing value
  String _foo;

  /// 2. Create the reactive setter
  set foo(String e) {
    _foo = e;
    notifyListeners();
  }

  /// 3. Persist data to [SharedPreferences]
  /// 4. Hydrate data from [SharedPreferences]
}
