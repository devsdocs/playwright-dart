class ProtocolModel {
  ProtocolModel({this.name = ''});
  String name;
  Map<String, ProtocolModel> children = {};
  factory ProtocolModel.fromJson(Map<String, dynamic> json) {
    return ProtocolModel()..name = json['name'] as String;
  }
}
