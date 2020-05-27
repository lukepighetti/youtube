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

      /// Dependencies & hydration in constructor
      "_\$${visitor.className}ChangeNotifier(this.sharedPreferences) {",
      "  hydrateFields();",
      "}",

      "final SharedPreferences sharedPreferences;\n",

      for (var getter in visitor.getters.entries) ...[
        /// Backing value
        "${getter.value.returnType} _${getter.key};",

        /// Storage key
        "final _${getter.key}StorageKey = \"${visitor.className}.${getter.key}\";",

        /// Reactive setter
        "set ${getter.key} (${getter.value.returnType} e) {",
        "  _${getter.key} = e;",

        /// Persistence
        if (isSharedPreferencesCoreType(getter.value.returnType))
          "  sharedPreferences.set${sharedPreferencesMethod(getter.value.returnType)}(_${getter.key}StorageKey, e);"

        /// Unsupported type, assume it's `json_serializable`
        else
          "  sharedPreferences.setString(_${getter.key}StorageKey, jsonEncode(e.toJson()));",

        "  notifyListeners();",
        "}",
      ],

      /// 4. Hydrate all fields
      "  hydrateFields() {",
      for (var getter in visitor.getters.entries) ...[
        if (isSharedPreferencesCoreType(getter.value.returnType))
          "  _${getter.key} = sharedPreferences.get${sharedPreferencesMethod(getter.value.returnType)}(_${getter.key}StorageKey);"

        /// Unsupported type, assume it's `json_serializable`
        else
          "  _${getter.key} = ${getter.value.returnType}.fromJson(jsonDecode(sharedPreferences.getString(_${getter.key}StorageKey)));"
      ],
      " notifyListeners();",
      "  }",
      "}"
    ];

    return lines.join("");
  }

  /// Which `shared_preferences` methods should we use for this [DartType]?
  String sharedPreferencesMethod(DartType type) {
    if (type.isDartCoreString) return "String";
    if (type.isDartCoreBool) return "Bool";
    if (type.isDartCoreDouble) return "Double";
    if (type.isDartCoreInt) return "Int";
    if (type.getDisplayString() == "List<String>") return "StringList";
    return null;
  }

  /// Is this [DartType] supported by `shared_preferences`?
  ///
  /// If not, we should probably pretend it's a `json_serializable` model
  bool isSharedPreferencesCoreType(DartType type) {
    if (type.isDartCoreString) return true;
    if (type.isDartCoreBool) return true;
    if (type.isDartCoreDouble) return true;
    if (type.isDartCoreInt) return true;
    if (type.getDisplayString() == "List<String>") return true;
    return false;
  }
}

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
