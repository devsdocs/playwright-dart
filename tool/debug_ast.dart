import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';

String getLexeme(dynamic node) {
  try {
    return node.name2.lexeme as String;
  } catch (_) {}
  try {
    return node.name.lexeme as String;
  } catch (_) {}
  try {
    return node.name.name as String;
  } catch (_) {}
  try {
    return node.toSource() as String;
  } catch (_) {
    return '';
  }
}

void main() {
  final file = File('lib/src/core/page.dart');
  final content = file.readAsStringSync();
  final result = parseString(
    content: content,
    path: file.path,
    throwIfDiagnostics: false,
  );

  for (dynamic declaration in result.unit.declarations) {
    try {
      final extendsClause = declaration.extendsClause;
      if (extendsClause != null) {
        final superclassName = extendsClause.superclass.toSource();
        if (superclassName.toString().endsWith('Base')) {
          print(
            'Found class: \${getLexeme(declaration)} extends \$superclassName',
          );

          dynamic members;
          try {
            members = declaration.members;
          } catch (e) {
            continue;
          }

          print('Members count: \${members.length}');
          for (dynamic member in members) {
            print('Member type: \${member.runtimeType}');
            // test getting name
            try {
              getLexeme(member);
            } catch (e) {
              print('Error getting name');
            }
            print('Member name: \$name');
          }
        }
      }
      // ignore: empty_catches
    } catch (e) {}
  }
}
