// generate_fields.dart

import 'package:flutter/material.dart';

import '../../../date/FieldModel.dart';
import 'inputFileds.dart';
List<Widget> generateFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    List<FieldModel> fields,
    Map<String, String> errorMessages,
    Map<String, Function?> onChangedCallbacks,
    Map<String, dynamic> values,
    ) {
  return fields.where((field) => shouldFieldBeVisible(field, values)).map((field) {
    switch (field.type) {
      case 'text':
      case 'number':
        return buildTextField(controllers, field, errorMessages);
      case 'dropdown':
        return buildDropdownField(field, errorMessages, onChangedCallbacks[field.slug]! as Function(String?));
      case 'multidropdown':
        return buildMultiDropdownField(field, errorMessages, onChangedCallbacks[field.slug]! as Function(List<String>?), controllers);
      case 'checkbox':
        return buildCheckboxField(field, values[field.slug], errorMessages, onChangedCallbacks[field.slug]! as Function(bool?));
      case 'date':
        return buildDatePickerField(context, field, values[field.slug], errorMessages, onChangedCallbacks[field.slug]! as Function(DateTime?));
      default:
        return Container();
    }
  }).toList();
}





