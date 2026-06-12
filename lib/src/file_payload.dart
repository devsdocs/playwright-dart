import 'dart:convert';

class FilePayload {
  final String name;
  final String mimeType;
  final List<int> buffer;

  FilePayload({
    required this.name,
    required this.mimeType,
    required this.buffer,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'mimeType': mimeType, 'buffer': base64Encode(buffer)};
  }
}
