import '../interaction/element_handle.dart';
import '../infrastructure/file_payload.dart';

class SelectOption {
  final String? value;
  final String? label;
  final int? index;
  final ElementHandle? element;

  const SelectOption({this.value, this.label, this.index, this.element});

  factory SelectOption.value(String value) => SelectOption(value: value);
  factory SelectOption.label(String label) => SelectOption(label: label);
  factory SelectOption.index(int index) => SelectOption(index: index);
  factory SelectOption.element(ElementHandle element) =>
      SelectOption(element: element);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (value != null) map['value'] = value;
    if (label != null) map['label'] = label;
    if (index != null) map['index'] = index;
    // element handle is serialized differently by the Playwright connection.
    // For now we assume the connection handles ElementHandles passed in maps/lists.
    if (element != null) map['element'] = element;
    return map;
  }
}

class InputFile {
  final String? path;
  final FilePayload? payload;

  const InputFile.path(String this.path) : payload = null;
  const InputFile.payload(FilePayload this.payload) : path = null;
}
