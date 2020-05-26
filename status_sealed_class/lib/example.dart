import 'package:flutter/material.dart';
import 'package:ssc/status.dart';

class ExampleWidget extends StatelessWidget {
  final Status<ViewModel, MyAppError> viewModel;

  const ExampleWidget({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return viewModel.where(
      onInitial: () => Text("onInitial"),
      onWaiting: () => CircularProgressIndicator(),
      onError: (e) => Text("$e"),
      onData: (d) => Text(d.message),
    );
  }
}

class ViewModel {
  final String message;

  ViewModel(this.message);
}

class MyAppError extends Error {
  final String message;
  final DateTime thrownAt;

  MyAppError(this.message) : thrownAt = DateTime.now();

  @override
  String toString() => "[MyAppError]: $message";
}
