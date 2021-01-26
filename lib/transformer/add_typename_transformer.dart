import 'package:gql/ast.dart';

/// adds type name resolving to all schema types
class AppendTypename extends TransformingVisitor {
  /// type name value
  final String typeName;

  /// adds type name resolving to all schema types
  AppendTypename(this.typeName);

  @override

  /// appends type name to OperationDefinitionNode
  @override
  OperationDefinitionNode visitOperationDefinitionNode(
      OperationDefinitionNode node) {
    return OperationDefinitionNode(
      type: node.type,
      name: node.name,
      variableDefinitions: node.variableDefinitions,
      directives: node.directives,
      span: node.span,
      selectionSet: SelectionSetNode(
        selections: <SelectionNode>[
          FieldNode(name: NameNode(value: typeName)),
          ...node.selectionSet.selections.where((element) =>
              (element is! FieldNode) ||
              (element is FieldNode && element.name.value != typeName))
        ],
      ),
    );
  }

  /// appends type name to FragmentDefinitionNode
  @override
  FragmentDefinitionNode visitFragmentDefinitionNode(
      FragmentDefinitionNode node) {
    return FragmentDefinitionNode(
      name: node.name,
      typeCondition: node.typeCondition,
      directives: node.directives,
      span: node.span,
      selectionSet: SelectionSetNode(
        selections: <SelectionNode>[
          FieldNode(name: NameNode(value: typeName)),
          ...node.selectionSet.selections.where((element) =>
              (element is! FieldNode) ||
              (element is FieldNode && element.name.value != typeName))
        ],
      ),
    );
  }

  /// appends type name to OperationDefinitionNode
  @override
  InlineFragmentNode visitInlineFragmentNode(InlineFragmentNode node) {
    if (node.selectionSet == null) {
      return node;
    }

    return InlineFragmentNode(
      typeCondition: node.typeCondition,
      directives: node.directives,
      span: node.span,
      selectionSet: SelectionSetNode(
        selections: <SelectionNode>[
          FieldNode(name: NameNode(value: typeName)),
          ...node.selectionSet.selections.where((element) =>
              (element is! FieldNode) ||
              (element is FieldNode && element.name.value != typeName))
        ],
      ),
    );
  }

  /// appends type name to OperationDefinitionNode
  @override
  FieldNode visitFieldNode(FieldNode node) {
    if (node.selectionSet == null) {
      return node;
    }

    return FieldNode(
      name: node.name,
      alias: node.alias,
      arguments: node.arguments,
      directives: node.directives,
      span: node.span,
      selectionSet: SelectionSetNode(
        selections: <SelectionNode>[
          FieldNode(name: NameNode(value: typeName)),
          ...node.selectionSet.selections.where((element) =>
              (element is! FieldNode) ||
              (element is FieldNode && element.name.value != typeName))
        ],
      ),
    );
  }
}
