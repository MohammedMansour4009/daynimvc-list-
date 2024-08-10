import '../date/FieldModel.dart';
import '../date/FieldRepository.dart';

class FieldViewModel {
  final FieldRepository repository;
  List<FieldModel> fields = [];

  FieldViewModel(this.repository) {
    fetchFields();
  }

  void fetchFields() {
    fields = repository.fetchFields();
  }
}
