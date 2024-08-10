// form_validator_helper.dart

import 'package:flutter/material.dart';

import '../../../date/FieldModel.dart';

class FormValidatorHelper {
  static void validateTextField(
      FieldModel field,
      Map<String, TextEditingController> controllers,
      Map<String, String> errorMessages,
      bool allRequiredFieldsFilled,
      ) {
    if (controllers[field.name]!.text.isEmpty) {
      allRequiredFieldsFilled = false;
      errorMessages[field.name] = 'Please fill ${field.name}';
    }
  }

  static void validateDropdownField(
      FieldModel field,
      Map<String, dynamic> values,
      Map<String, String> errorMessages,
      bool allRequiredFieldsFilled,
      ) {
    if (values[field.name] == null) {
      allRequiredFieldsFilled = false;
      errorMessages[field.name] = 'Please select ${field.name}';
    }
  }

  static void validateCheckboxField(
      FieldModel field,
      Map<String, dynamic> values,
      Map<String, String> errorMessages,
      bool allRequiredFieldsFilled,
      ) {
    if (values[field.name] != true) {
      allRequiredFieldsFilled = false;
      errorMessages[field.name] = 'Please accept ${field.name}';
    }
  }

  static void validateDateField(
      FieldModel field,
      Map<String, dynamic> values,
      Map<String, String> errorMessages,
      bool allRequiredFieldsFilled,
      ) {
    if (values[field.name] == null) {
      allRequiredFieldsFilled = false;
      errorMessages[field.name] = 'Please select ${field.name}';
    }
  }

  static bool validateForm(
      List<FieldModel> fields,
      Map<String, TextEditingController> controllers,
      Map<String, dynamic> values,
      Map<String, String> errorMessages,
      ) {
    bool allRequiredFieldsFilled = true;
    errorMessages.clear();

    fields.forEach((field) {
      if (field.required) {
        if (field.type == 'text' || field.type == 'number') {
          validateTextField(field, controllers, errorMessages, allRequiredFieldsFilled);
        } else if (field.type == 'dropdown') {
          validateDropdownField(field, values, errorMessages, allRequiredFieldsFilled);
        } else if (field.type == 'checkbox') {
          validateCheckboxField(field, values, errorMessages, allRequiredFieldsFilled);
        } else if (field.type == 'date') {
          validateDateField(field, values, errorMessages, allRequiredFieldsFilled);
        }
      }
    });

    return allRequiredFieldsFilled;
  }
}
