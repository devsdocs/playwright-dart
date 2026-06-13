import 'dart:convert';
import 'generated/channels.dart';

dynamic parseSerializedValue(SerializedValue value) {
  if (value.n != null) return value.n;
  if (value.b != null) return value.b;
  if (value.s != null) return value.s;
  if (value.v != null) {
    final v = value.v!.value;
    if (v == 'undefined' || v == 'null') return null;
    if (v == 'NaN') return double.nan;
    if (v == 'Infinity') return double.infinity;
    if (v == '-Infinity') return double.negativeInfinity;
  }
  if (value.a != null) {
    return value.a!.map((e) => parseSerializedValue(e)).toList();
  }
  if (value.o != null) {
    final result = <String, dynamic>{};
    for (final entry in value.o!) {
      result[entry['k'] as String] = parseSerializedValue(
        SerializedValue.fromJson(entry['v'] as Map<String, dynamic>),
      );
    }
    return result;
  }
  return null;
}

SerializedArgument serializeArgument(dynamic value) {
  return SerializedArgument(value: serializeValue(value), handles: []);
}

SerializedValue serializeValue(dynamic value) {
  if (value == null) return SerializedValue(v: SerializedValueVEnum.undefined);
  if (value is int) return SerializedValue(n: value.toDouble());
  if (value is double) return SerializedValue(n: value);
  if (value is bool) return SerializedValue(b: value);
  if (value is String) return SerializedValue(s: value);
  if (value is List) {
    return SerializedValue(a: value.map((e) => serializeValue(e)).toList());
  }
  if (value is Map<String, dynamic>) {
    final o = value.entries
        .map((e) => {'k': e.key, 'v': serializeValue(e.value).toJson()})
        .toList();
    return SerializedValue(o: o);
  }
  return SerializedValue(v: SerializedValueVEnum.undefined);
}

class SelectOptionParams {
  final List<ElementHandleBase>? elements;
  final List<Map<String, dynamic>>? options;
  SelectOptionParams({this.elements, this.options});
}

SelectOptionParams parseSelectOptions(dynamic values) {
  if (values == null) return SelectOptionParams();

  final elements = <ElementHandleBase>[];
  final options = <Map<String, dynamic>>[];

  final list = values is List ? values : [values];
  for (final item in list) {
    if (item is ElementHandleBase) {
      elements.add(item);
    } else if (item is Map) {
      options.add(item.cast<String, dynamic>());
    } else if (item is String) {
      options.add({'valueOrLabel': item});
    }
  }

  return SelectOptionParams(
    elements: elements.isNotEmpty ? elements : null,
    options: options.isNotEmpty ? options : null,
  );
}

class InputFilesParams {
  final List<Map<String, dynamic>>? payloads;
  final List<String>? localPaths;
  InputFilesParams({this.payloads, this.localPaths});
}

InputFilesParams parseInputFiles(dynamic files) {
  if (files == null) return InputFilesParams();

  final payloads = <Map<String, dynamic>>[];
  final localPaths = <String>[];

  final list = files is List ? files : [files];
  for (final item in list) {
    if (item is String) {
      localPaths.add(item);
    } else if (item is Map) {
      final map = item.cast<String, dynamic>();
      if (map['buffer'] is List<int>) {
        map['buffer'] = base64Encode(map['buffer'] as List<int>);
      }
      payloads.add(map);
    } else {
      try {
        payloads.add(item.toJson() as Map<String, dynamic>);
      } catch (_) {}
    }
  }

  return InputFilesParams(
    payloads: payloads.isNotEmpty ? payloads : null,
    localPaths: localPaths.isNotEmpty ? localPaths : null,
  );
}
