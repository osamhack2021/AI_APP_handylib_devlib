
import 'package:flutter/material.dart';

class ErrorNotifier extends StatelessWidget {
  final String? errorMessage;

  const ErrorNotifier({Key? key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 48.0),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('${errorMessage}'),
        ),
      ],
    ));
  }
}