/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the TestTable type in your schema. */
@immutable
class TestTable extends Model {
  static const classType = const _TestTableModelType();
  final String id;
  final String test;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const TestTable._internal({@required this.id, this.test});

  factory TestTable({String id, String test}) {
    return TestTable._internal(
        id: id == null ? UUID.getUUID() : id, test: test);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TestTable && id == other.id && test == other.test;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("TestTable {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("test=" + "$test");
    buffer.write("}");

    return buffer.toString();
  }

  TestTable copyWith({String id, String test}) {
    return TestTable(id: id ?? this.id, test: test ?? this.test);
  }

  TestTable.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        test = json['test'];

  Map<String, dynamic> toJson() => {'id': id, 'test': test};

  static final QueryField ID = QueryField(fieldName: "testTable.id");
  static final QueryField TEST = QueryField(fieldName: "test");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TestTable";
    modelSchemaDefinition.pluralName = "TestTables";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: TestTable.TEST,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _TestTableModelType extends ModelType<TestTable> {
  const _TestTableModelType();

  @override
  TestTable fromJson(Map<String, dynamic> jsonData) {
    return TestTable.fromJson(jsonData);
  }
}
