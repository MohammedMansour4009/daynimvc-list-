// field_initializer_helper.dart

import 'package:flutter/material.dart';

import '../../../date/FieldModel.dart';
class FieldInitializerHelper {
  static void initializeFieldValues(
      List<FieldModel> fields,
      Map<String, TextEditingController> controllers,
      Map<String, dynamic> values,
      Map<String, Function?> onChangedCallbacks,
      Function setStateCallback,
      ) {
    fields.forEach((field) {
      if (field.type == 'text' || field.type == 'number') {
        controllers[field.slug] = TextEditingController();
      } else if (field.type == 'dropdown') {
        values[field.slug] = null;
        onChangedCallbacks[field.slug] = (String? newValue) {
          setStateCallback(() {
            values[field.slug] = newValue;
          });
        };
      } else if (field.type == 'multidropdown') {
        values[field.slug] = <String>[];
        onChangedCallbacks[field.slug] = (List<String>? newValues) {
          setStateCallback(() {
            values[field.slug] = newValues;
          });
        };
      } else if (field.type == 'checkbox') {
        values[field.slug] = field.initialValue;
        onChangedCallbacks[field.slug] = (bool? newValue) {
          setStateCallback(() {
            values[field.slug] = newValue;
          });
        };
      } else if (field.type == 'date') {
        values[field.slug] = null;
        onChangedCallbacks[field.slug] = (DateTime? newValue) {
          setStateCallback(() {
            values[field.slug] = newValue;
          });
        };
      }
    });
  }
}

