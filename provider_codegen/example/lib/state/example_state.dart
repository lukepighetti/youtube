import 'package:provider_annotation/provider_annotation.dart';

part 'example_state.state.dart';

@StateClass()
class ExampleState extends _$ExampleStateChangeNotifier {
  @StateField()
  String get foo => _foo;

  @StateField()
  bool get bar => _bar;
}
