library state_codegen;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:state_annotation/state_annotation.dart';

class StateGenerator extends GeneratorForAnnotation<StateClass> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = GetterFieldVisitor();
    element.visitChildren(visitor);

    final lines = [
      "class _\$${visitor.className}ChangeNotifier extends ChangeNotifier {",
      "  _\$${visitor.className}ChangeNotifier(this.sharedPreferences);",
      "final SharedPreferences sharedPreferences;",
      for (var getter in visitor.getters.entries) ...[
        /// 1. Backing value
        "${getter.value.returnType} _${getter.key};",

        /// 2. Storage key
        "final _${getter.key}StorageKey = \"${visitor.className}.${getter.key}\";",

        /// 3. Reactive setter
        "set ${getter.key} (${getter.value.returnType} e) {",
        "  _${getter.key} = e;",
        "  sharedPreferences.setString(_${getter.key}StorageKey, e);", 
        "  notifyListeners();",
        "}",
      ],
      "}"
    ];

    return lines.join("");
  }
}

// set foo(String e) {
//   _foo = e;
//   notifyListeners();
// }

/// Dispatches build commands to [StateGenerator]
Builder stateBuilder(BuilderOptions options) =>
    PartBuilder([StateGenerator()], ".state.dart");

/// Returns field getters on an element
class GetterFieldVisitor extends SimpleElementVisitor {
  DartType className;
  Map<String, PropertyAccessorElement> getters = {};

  @override
  visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
  }

  @override
  visitFieldElement(FieldElement element) {
    final getter = element.getter;

    if (getter != null) {
      getters[element.name] = getter;
    }
  }
}
