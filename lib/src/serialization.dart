import 'generated/channels.dart';

dynamic parseSerializedValue(Map<String, dynamic> value) {
  if (value.containsKey('n')) return value['n'];
  if (value.containsKey('b')) return value['b'];
  if (value.containsKey('s')) return value['s'];
  if (value.containsKey('v')) {
    final v = value['v'];
    if (v == 'undefined' || v == 'null') return null;
    if (v == 'NaN') return double.nan;
    if (v == 'Infinity') return double.infinity;
    if (v == '-Infinity') return double.negativeInfinity;
  }
  if (value.containsKey('a')) {
    final list = value['a'] as List;
    return list.map((e) => parseSerializedValue(e as Map<String, dynamic>)).toList();
  }
  if (value.containsKey('o')) {
    final obj = value['o'] as List;
    final result = <String, dynamic>{};
    for (final entry in obj) {
      result[entry['name'] as String] = parseSerializedValue(entry['value'] as Map<String, dynamic>);
    }
    return result;
  }
  return value;
}

SerializedArgument serializeArgument(dynamic value) {
  return SerializedArgument(value: serializeValue(value), handles: []);
}

SerializedValue serializeValue(dynamic value) {
  if (value == null) return SerializedValue(v: 'undefined');
  if (value is int) return SerializedValue(n: value.toDouble());
  if (value is double) return SerializedValue(n: value);
  if (value is bool) return SerializedValue(b: value);
  if (value is String) return SerializedValue(s: value);
  if (value is List) {
    return SerializedValue(a: value.map((e) => serializeValue(e)).toList());
  }
  if (value is Map<String, dynamic>) {
    final o = value.entries
        .map((e) => {'name': e.key, 'value': serializeValue(e.value).toJson()})
        .toList();
    return SerializedValue(o: o);
  }
  return SerializedValue(v: 'undefined');
}
