import 'package:flutter/material.dart';

import '../FieldViewModel.dart';
import 'Helper/FormValidatorHelper.dart';
import 'helper/FieldInitializerHelper.dart';
import 'inputFiled/generateFields.dart';

class DynamicForm extends StatefulWidget {
  final FieldViewModel viewModel;

  DynamicForm({required this.viewModel});

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _errorMessages = {};
  final Map<String, dynamic> _values = {};
  final Map<String, Function?> _onChangedCallbacks = {};

  @override
  void initState() {
    super.initState();
    FieldInitializerHelper.initializeFieldValues(
      widget.viewModel.fields,
      _controllers,
      _values,
      _onChangedCallbacks,
      setState,
    );
  }

  void _submitForm() {
    setState(() {
      bool allRequiredFieldsFilled = FormValidatorHelper.validateForm(
        widget.viewModel.fields,
        _controllers,
        _values,
        _errorMessages,
      );

      if (allRequiredFieldsFilled) {
        // Handle form submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form submitted successfully!')),
        );
      } else {
        // Show error messages
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all required fields.')),
        );
      }
    });
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...generateFields(context, _controllers, widget.viewModel.fields, _errorMessages, _onChangedCallbacks, _values),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
