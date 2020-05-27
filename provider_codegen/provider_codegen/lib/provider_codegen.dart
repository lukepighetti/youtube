library provider_codegen;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:provider_annotation/provider_annotation.dart';
import 'package:source_gen/source_gen.dart';

class ProviderGenerator extends GeneratorForAnnotation<StateClass> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = GetterFieldVisitor();
    element.visitChildren(visitor);

    return [
      "class _\$${visitor.className}ChangeNotifier {",
      for (final getter in visitor.getters.entries)
        "${getter.value.returnType} _${getter.key};",
      "}",
    ];

    return """
      var _foo = "foo";
    """;
  }
}

/// The builder for [ProviderGenerator]
Builder providerBuilder(BuilderOptions options) =>
    PartBuilder([ProviderGenerator()], '.state.dart');

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
