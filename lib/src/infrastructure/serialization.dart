import 'dart:convert';
import '../interaction/interaction_types.dart';
import '../generated/channels.dart';

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
    if (v == '-0') return -0.0;
  }
  if (value.r != null) {
    // Parse regex: {p: pattern, f: flags}
    final pattern = value.r!.p;
    final flags = value.r!.f;
    try {
      return RegExp(
        pattern,
        multiLine: flags.contains('m'),
        caseSensitive: !flags.contains('i'),
        dotAll: flags.contains('s'),
        unicode: flags.contains('u'),
      );
    } catch (_) {
      return pattern; // Fallback to string if regex parsing fails
    }
  }
  if (value.a != null) {
    return value.a!.map((e) => parseSerializedValue(e)).toList();
  }
  if (value.o != null) {
    final result = <String, dynamic>{};
    for (final entry in value.o!) {
      result[entry.k] = parseSerializedValue(entry.v);
    }
    return result;
  }
  return null;
}

/// Casts a deserialized JS value to [T], handling the JS number quirk:
/// JavaScript has no integers — all numbers arrive as [double].
/// When [T] is [int] and the value is a whole number, this converts
/// automatically so callers can write `evaluate<int>(...)` naturally.
T castEvaluateResult<T>(dynamic value) {
  if (value is double && T == int) {
    return value.toInt() as T;
  }
  return value as T;
}

SerializedArgument serializeArgument(dynamic value) {
  return SerializedArgument(value: serializeValue(value), handles: []);
}

SerializedValue serializeValue(dynamic value) {
  if (value == null) return SerializedValue(v: V.undefined);
  if (value is int) return SerializedValue(n: value.toDouble());
  if (value is double) {
    if (value.isNaN) return SerializedValue(v: V.nan);
    if (value == double.infinity) {
      return SerializedValue(v: V.infinity);
    }
    if (value == double.negativeInfinity) {
      return SerializedValue(v: V.minusInfinity);
    }
    if (value == 0.0 && value.isNegative) {
      return SerializedValue(v: V.minusZero);
    }
    return SerializedValue(n: value);
  }
  if (value is bool) return SerializedValue(b: value);
  if (value is String) return SerializedValue(s: value);
  if (value is RegExp) {
    // Serialize regex: {p: pattern, f: flags}
    final flags = <String>[];
    if (!value.isCaseSensitive) flags.add('i');
    if (value.isMultiLine) flags.add('m');
    if (value.isDotAll) flags.add('s');
    if (value.isUnicode) flags.add('u');
    return SerializedValue(
      r: SerializedValueR(p: value.pattern, f: flags.join()),
    );
  }
  if (value is List) {
    return SerializedValue(a: value.map((e) => serializeValue(e)).toList());
  }
  if (value is Map<String, dynamic>) {
    final objects = value.entries
        .map((e) => SerializedValueOItems(k: e.key, v: serializeValue(e.value)))
        .toList();
    return SerializedValue(o: objects);
  }
  return SerializedValue(v: V.undefined);
}

class SelectOptionParams {
  final List<ElementHandleBase>? elements;
  final List<Map<String, dynamic>>? options;
  SelectOptionParams({this.elements, this.options});
}

SelectOptionParams parseSelectOptions(List<SelectOption>? values) {
  if (values == null) return SelectOptionParams();

  final elements = <ElementHandleBase>[];
  final options = <Map<String, dynamic>>[];

  for (final item in values) {
    if (item.element != null) {
      elements.add(item.element as ElementHandleBase);
    } else if (item.value != null || item.label != null || item.index != null) {
      options.add(item.toJson());
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

InputFilesParams parseInputFiles(List<InputFile>? files) {
  if (files == null) return InputFilesParams();

  final payloads = <Map<String, dynamic>>[];
  final localPaths = <String>[];

  for (final item in files) {
    if (item.path != null) {
      localPaths.add(item.path!);
    } else if (item.payload != null) {
      final map = item.payload!.toJson();
      if (map['buffer'] is List<int>) {
        map['buffer'] = base64Encode(map['buffer'] as List<int>);
      }
      payloads.add(map);
    }
  }

  return InputFilesParams(
    payloads: payloads.isNotEmpty ? payloads : null,
    localPaths: localPaths.isNotEmpty ? localPaths : null,
  );
}
