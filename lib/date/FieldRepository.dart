import 'FieldModel.dart';
class FieldRepository {
  List<FieldModel> fetchFields() {
    return [
      FieldModel('Name', 'name', 'text', required: true),
      FieldModel('Email', 'email', 'text', required: true),
      FieldModel('Age', 'age', 'number'),
      FieldModel('Gender', 'gender', 'dropdown', options: ['Male', 'Female', 'Other'], required: true),
      FieldModel('Accept Terms', 'accept_terms', 'checkbox', initialValue: false, required: true),
      FieldModel('Date of Birth', 'dob', 'date', required: true),
      FieldModel('Driving License', 'driving_license', 'text', required: true, dependsOn: 'gender', visibleWhen: 'Male'),
      FieldModel('Academic Level', 'academic_level', 'text', required: true, dependsOn: 'gender', visibleWhen: 'Female'),
      FieldModel('Note', 'note', 'text', required: false, dependsOn: 'accept_terms', visibleWhen: true),
      FieldModel('Favorite Subjects', 'favorite_subjects', 'multidropdown', options: ['Math', 'Science', 'History', 'Art'], required: false),
      FieldModel('Special Note for Science', 'science_note', 'text', required: false, dependsOn: 'favorite_subjects', visibleWhen: 'Science'), // New field dependent on multidropdown
    ];
  }
}
