class FieldModel {
  final String name;
  final String slug; // Required unique identifier
  final String type;
  final bool required;
  final List<String>? options; // For dropdown fields
  final bool? initialValue; // For checkbox fields
  final String? dependsOn; // Slug of the field this field depends on
  final dynamic visibleWhen; // Value of the `dependsOn` field that triggers visibility (can be bool for checkboxes)

  FieldModel(
      this.name,
      this.slug, // Slug is required
      this.type, {
        this.required = false,
        this.options,
        this.initialValue,
        this.dependsOn,
        this.visibleWhen,
      });
}
