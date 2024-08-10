import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../date/FieldRepository.dart';
import '../FieldViewModel.dart';
import 'DynamicList.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FieldViewModel viewModel;

  @override
  void initState() {
    super.initState();
    final repository = FieldRepository();
    viewModel = FieldViewModel(repository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Form Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: DynamicForm(viewModel: viewModel),
        ),
      ),
    );
  }
}



