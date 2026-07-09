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
  final dir = Directory('lib/src');
  for (final file in dir.listSync().whereType<File>()) {
    if (!file.path.endsWith('.dart') ||
        file.path.contains('channel_owner') ||
        file.path.contains('connection')) {
      continue;
    }

    final content = file.readAsStringSync();
    final result = parseString(
      content: content,
      path: file.path,
      throwIfDiagnostics: false,
    );
    final unit = result.unit;

    final classesToRefactor = <dynamic>[];
    for (dynamic declaration in unit.declarations) {
      try {
        final extendsClause = declaration.extendsClause;
        if (extendsClause != null) {
          final superclassName = extendsClause.superclass.toSource();
          if (superclassName.toString().endsWith('Base')) {
            classesToRefactor.add(declaration);
          }
        }
      } catch (e) {
        // Not a class or doesn't have extendsClause
      }
    }

    if (classesToRefactor.isEmpty) continue;

    var newContent = content;
    var offsetDelta = 0;

    for (dynamic clazz in classesToRefactor) {
      final className = getLexeme(clazz);
      final interfaceMethods = <String>[];

      dynamic members;
      try {
        members = clazz.members;
      } catch (e) {
        continue; // doesn't have members
      }

      for (dynamic member in members) {
        final isStatic = member.isStatic == true;
        if (isStatic) continue;

        try {
          if (member.runtimeType.toString().contains('MethodDeclaration')) {
            final name = getLexeme(member);
            if (name.startsWith('_')) continue;

            // Do not copy overrides
            bool isOverride = false;
            try {
              for (dynamic annotation in member.metadata) {
                if (annotation.name.name == 'override') {
                  isOverride = true;
                }
              }
              // ignore: empty_catches
            } catch (e) {}
            if (isOverride) continue;

            final isGetter = member.isGetter == true;
            final isSetter = member.isSetter == true;
            final type = member.returnType?.toSource() ?? '';
            // parameters toSource will contain default values like `= 30000.0`. Interfaces shouldn't have default values!
            // Wait, Dart allows default values in interfaces, and they must match the implementation. It's actually required if the impl has them.
            final params = member.parameters?.toSource() ?? '';

            if (isGetter) {
              interfaceMethods.add(
                '  ${type.isNotEmpty ? type + ' ' : ''}get $name;',
              );
            } else if (isSetter) {
              interfaceMethods.add('  set $name$params;');
            } else {
              interfaceMethods.add(
                '  ${type.isNotEmpty ? type + ' ' : ''}$name$params;',
              );
            }
          } else if (member.runtimeType.toString().contains(
            'FieldDeclaration',
          )) {
            for (dynamic variable in member.fields.variables) {
              final name = getLexeme(variable);
              if (name.startsWith('_')) continue;
              final type = member.fields.type?.toSource() ?? 'dynamic';
              interfaceMethods.add('  $type get $name;');
              if (member.fields.isFinal != true) {
                interfaceMethods.add('  set $name($type value);');
              }
            }
          }
        } catch (e) {
          print('Error processing member in $className: $e');
        }
      }

      final interfaceDoc = clazz.documentationComment?.toSource() ?? '';

      final interfaceCode =
          '''
$interfaceDoc
abstract interface class $className {
${interfaceMethods.join('\n')}
}

''';

      // 1. Insert the interface before the class
      final insertPos = (clazz.offset as int) + offsetDelta;
      newContent =
          newContent.substring(0, insertPos) +
          interfaceCode +
          newContent.substring(insertPos);
      offsetDelta += interfaceCode.length;

      // 2. Rename the class to XImpl and add implements X
      final classKeywordOffset =
          (clazz.classKeyword.offset as int) + offsetDelta;
      final classHeaderEnd = (clazz.leftBracket.offset as int) + offsetDelta;

      final oldHeader = newContent.substring(
        classKeywordOffset,
        classHeaderEnd,
      );
      var newHeader = oldHeader.replaceFirst(
        'class $className',
        'class \${className}Impl',
      );

      if (newHeader.contains('implements')) {
        newHeader = newHeader.replaceFirst(
          'implements',
          'implements $className, ',
        );
      } else {
        newHeader = '${newHeader.trimRight()} implements $className ';
      }

      newContent =
          newContent.substring(0, classKeywordOffset) +
          newHeader +
          newContent.substring(classHeaderEnd);
      offsetDelta += (newHeader.length - oldHeader.length);
    }

    file.writeAsStringSync(newContent);
    print('Refactored \${file.path}');
  }
}
