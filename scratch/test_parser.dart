Map<String, String> _parseDartParams(List<String> lines, int declStart) {
  final params = <String, String>{};
  if (declStart < 0 || declStart >= lines.length) return params;

  String sig = '';
  int openParen = 0;
  bool started = false;

  for (int i = declStart; i < lines.length; i++) {
    final line = lines[i];
    sig += '$line ';

    for (int j = 0; j < line.length; j++) {
      if (line[j] == '(') {
        openParen++;
        started = true;
      } else if (line[j] == ')') {
        openParen--;
      }
    }

    if (started && openParen == 0) {
      break;
    }
  }

  final start = sig.indexOf('(');
  final end = sig.lastIndexOf(')');
  if (start == -1 || end == -1 || start >= end) return params;

  final argsStr = sig.substring(start + 1, end);

  final args = <String>[];
  int angleBrackets = 0;
  int parenCount = 0;
  int lastComma = 0;
  for (int i = 0; i < argsStr.length; i++) {
    if (argsStr[i] == '<') {
      angleBrackets++;
    } else if (argsStr[i] == '>') {
      angleBrackets--;
    } else if (argsStr[i] == '(') {
      parenCount++;
    } else if (argsStr[i] == ')') {
      parenCount--;
    } else if (argsStr[i] == ',' && angleBrackets == 0 && parenCount == 0) {
      args.add(argsStr.substring(lastComma, i));
      lastComma = i + 1;
    }
  }
  args.add(argsStr.substring(lastComma));

  for (String arg in args) {
    arg = arg.trim();
    if (arg.isEmpty) continue;

    arg = arg
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .trim();
    if (arg.isEmpty) continue;

    if (arg.startsWith('required ')) {
      arg = arg.substring('required '.length).trim();
    }

    final eqIndex = arg.indexOf('=');
    if (eqIndex != -1) {
      arg = arg.substring(0, eqIndex).trim();
    }

    final parts = arg.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      final name = parts.last;
      final typeWords = parts
          .sublist(0, parts.length - 1)
          .where((w) => !w.startsWith('@'))
          .toList();
      String type = typeWords.join(' ').trim();

      if (type.endsWith('?')) {
        type = type.substring(0, type.length - 1);
      }

      params[name] = type;
    }
  }

  return params;
}

void main() {
  final lines = [
    '  Future<Browser> connect(',
    '    String wsEndpoint, {',
    '    Map<String, String>? headers,',
    '    String? exposeNetwork,',
    '    double? slowMo,',
    '    double timeout = 30000.0,',
    '  }) async {',
  ];
  print(_parseDartParams(lines, 0));

  final lines2 = [
    '  Future<void> setWebSocketInterceptionPatterns(',
    '    List<PageSetWebSocketInterceptionPatternsPatternsItems> patterns,',
    '  );',
  ];
  print(_parseDartParams(lines2, 0));

  final lines3 = [
    '  Future<void> addInitScript(String script, {@deprecated dynamic arg});',
  ];
  print(_parseDartParams(lines3, 0));

  final lines4 = [
    '  Future<void> handle(void Function(Request req)? handler);',
  ];
  print(_parseDartParams(lines4, 0));
}
