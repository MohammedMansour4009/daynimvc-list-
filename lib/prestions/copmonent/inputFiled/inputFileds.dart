// generate_fields.dart

import 'package:flutter/material.dart';
import '../../../date/FieldModel.dart';
import 'package:intl/intl.dart'; // Add this for formatting the date

bool shouldFieldBeVisible(FieldModel field, Map<String, dynamic> values) {
  if (field.dependsOn == null) {
    return true;
  }

  final dependentValue = values[field.dependsOn!];

  // Handle multidropdown case
  if (dependentValue is List<String>) {
    return dependentValue.contains(field.visibleWhen);
  }

  // Handle other cases (e.g., single value dependencies)
  return dependentValue != null && dependentValue == field.visibleWhen;
}



Widget buildTextField(
    Map<String, TextEditingController> controllers,
    FieldModel field,
    Map<String, String> errorMessages,
    ) {
  return TextField(
    controller: controllers[field.name],
    decoration: InputDecoration(
      labelText: field.name,
      hintText: field.required ? 'Required' : null,
      errorText: errorMessages[field.name],
    ),
    keyboardType: field.type == 'number' ? TextInputType.number : TextInputType.text,
  );
}

Widget buildDropdownField(
    FieldModel field,
    Map<String, String> errorMessages,
    Function(String?) onChanged,
    ) {
  String? selectedValue;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: field.name,
          errorText: errorMessages[field.name],
        ),
        value: selectedValue,
        items: field.options?.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    ],
  );
}

Widget buildCheckboxField(
    FieldModel field,
    bool? checkedValue,
    Map<String, String> errorMessages,
    Function(bool?) onChanged,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CheckboxListTile(
        title: Text(field.name),
        value: checkedValue,
        onChanged: onChanged,
        subtitle: errorMessages[field.name] != null
            ? Text(
          errorMessages[field.name]!,
          style: TextStyle(color: Colors.red),
        )
            : null,
      ),
    ],
  );
}

Widget buildDatePickerField(
    BuildContext context,
    FieldModel field,
    DateTime? selectedDate,
    Map<String, String> errorMessages,
    Function(DateTime?) onChanged,
    ) {
  TextEditingController _dateController = TextEditingController();
  if (selectedDate != null) {
    _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: _dateController,
        decoration: InputDecoration(
          labelText: field.name,
          hintText: 'Select Date',
          errorText: errorMessages[field.name],
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            onChanged(pickedDate);
            _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate); // Update the text field
          }
        },
      ),
    ],
  );
}
Widget buildMultiDropdownField(
    FieldModel field,
    Map<String, String> errorMessages,
    Function(List<String>?) onChanged,
    Map<String, TextEditingController> controllers,
    ) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      List<String>? selectedValues = controllers.containsKey(field.slug)
          ? controllers[field.slug]?.text.split(',') : [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: field.name,
              errorText: errorMessages[field.name],
            ),
            value: null, // Dropdown's value should be null as we're using checkboxes
            items: field.options?.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: CheckboxListTile(
                  value: selectedValues?.contains(option),
                  title: Text(option),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedValues?.add(option);
                      } else {
                        selectedValues?.remove(option);
                      }
                      controllers[field.slug]?.text = selectedValues!.join(',');
                      onChanged(selectedValues);
                    });
                  },
                ),
              );
            }).toList(),
            onChanged: (_) {}, // No need to change the dropdown value directly
            isExpanded: true,
          ),
          if (selectedValues!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: selectedValues.map((selected) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: controllers[selected] ??= TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Enter details for $selected',
                    ),
                  ),
                );
              }).toList(),
            ),
          if (errorMessages[field.name] != null)
            Text(
              errorMessages[field.name]!,
              style: TextStyle(color: Colors.red),
            ),
        ],
      );
    },
  );
}





