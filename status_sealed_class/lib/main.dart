import 'package:flutter/material.dart';
import 'package:ssc/example.dart';
import 'package:ssc/status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Sealed Class',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: StreamBuilder<Status<ViewModel, MyAppError>>(
              initialData: Status.initial(),
              stream: fetchViewModel(),
              builder: (context, snapshot) {
                return ExampleWidget(
                  viewModel: snapshot.data,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Stream<Status<ViewModel, MyAppError>> fetchViewModel() async* {
    try {
      /// Initial
      yield Status.initial();
      await Future.delayed(Duration(seconds: 1));

      /// Waiting
      yield Status.waiting();
      await Future.delayed(Duration(seconds: 1));
      final response = await getViewModel();

      /// Data
      yield Status.data(response);
    } catch (e) {
      /// Error
      yield Status.error(MyAppError("$e" ?? "Error!"));
    }
  }

  Future<ViewModel> getViewModel() async {
    return ViewModel("This is the message!");
  }
}
