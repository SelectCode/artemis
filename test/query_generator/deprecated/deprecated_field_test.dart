// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:gql/language.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On deprecated', () {
    test(
      'Fields can be deprecated',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: QueryResponse
          }

          type QueryResponse {
            someObject: SomeObject @deprecated(reason: "message")
            someObjects: [SomeObject]
          }

          type SomeObject {
            someField: String
            deprecatedField: String @deprecated(reason: "message 2")
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
  query some_query {
    deprecatedObject: someObject {
      someField
      deprecatedField
    }
    someObjects {
      someField
      deprecatedField
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      document: parseString(query),
      operationName: r'some_query',
      name: QueryName(name: r'SomeQuery$_QueryResponse'),
      classes: [
        ClassDefinition(
          name: ClassName(name: r'SomeQuery$_QueryResponse$_deprecatedObject'),
          properties: [
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'someField'),
            ),
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'deprecatedField'),
              annotations: [r"Deprecated('message 2')"],
            ),
          ],
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        ),
        ClassDefinition(
          name: ClassName(name: r'SomeQuery$_QueryResponse$_SomeObject'),
          properties: [
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'someField'),
            ),
            ClassProperty(
              type: TypeName(name: r'String'),
              name: ClassPropertyName(name: r'deprecatedField'),
              annotations: [r"Deprecated('message 2')"],
            ),
          ],
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        ),
        ClassDefinition(
          name: ClassName(name: r'SomeQuery$_QueryResponse'),
          properties: [
            ClassProperty(
              type:
                  TypeName(name: r'SomeQuery$_QueryResponse$_deprecatedObject'),
              name: ClassPropertyName(name: r'deprecatedObject'),
              annotations: [r"Deprecated('message')"],
            ),
            ClassProperty(
              type: TypeName(name: r'List<SomeQuery$QueryResponse$SomeObject>'),
              name: ClassPropertyName(name: r'someObjects'),
            )
          ],
          factoryPossibilities: {},
          typeNameField: ClassPropertyName(name: r'__typename'),
          isInput: false,
        )
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse$DeprecatedObject extends JsonSerializable
    with EquatableMixin {
  SomeQuery$QueryResponse$DeprecatedObject();

  factory SomeQuery$QueryResponse$DeprecatedObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponse$DeprecatedObjectFromJson(json);

  String someField;

  @Deprecated('message 2')
  String deprecatedField;

  @override
  List<Object?> get props => [someField, deprecatedField];
  Map<String, dynamic> toJson() =>
      _$SomeQuery$QueryResponse$DeprecatedObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse$SomeObject extends JsonSerializable
    with EquatableMixin {
  SomeQuery$QueryResponse$SomeObject();

  factory SomeQuery$QueryResponse$SomeObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponse$SomeObjectFromJson(json);

  String someField;

  @Deprecated('message 2')
  String deprecatedField;

  @override
  List<Object?> get props => [someField, deprecatedField];
  Map<String, dynamic> toJson() =>
      _$SomeQuery$QueryResponse$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse extends JsonSerializable with EquatableMixin {
  SomeQuery$QueryResponse();

  factory SomeQuery$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponseFromJson(json);

  @Deprecated('message')
  SomeQuery$QueryResponse$DeprecatedObject deprecatedObject;

  List<SomeQuery$QueryResponse$SomeObject> someObjects;

  @override
  List<Object?> get props => [deprecatedObject, someObjects];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryResponseToJson(this);
}
''';
