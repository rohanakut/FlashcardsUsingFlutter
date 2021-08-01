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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the LoginTable type in your schema. */
@immutable
class LoginTable extends Model {
  static const classType = const _LoginTableModelType();
  final String id;
  final String userName;
  final String Password;
  final List<DeckListTable> DeckListTables;
  final List<CardsListTable> CardsListTables;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const LoginTable._internal(
      {@required this.id,
      @required this.userName,
      this.Password,
      this.DeckListTables,
      this.CardsListTables});

  factory LoginTable(
      {String id,
      @required String userName,
      String Password,
      List<DeckListTable> DeckListTables,
      List<CardsListTable> CardsListTables}) {
    return LoginTable._internal(
        id: id == null ? UUID.getUUID() : id,
        userName: userName,
        Password: Password,
        DeckListTables: DeckListTables != null
            ? List<DeckListTable>.unmodifiable(DeckListTables)
            : DeckListTables,
        CardsListTables: CardsListTables != null
            ? List<CardsListTable>.unmodifiable(CardsListTables)
            : CardsListTables);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginTable &&
        id == other.id &&
        userName == other.userName &&
        Password == other.Password &&
        DeepCollectionEquality().equals(DeckListTables, other.DeckListTables) &&
        DeepCollectionEquality().equals(CardsListTables, other.CardsListTables);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("LoginTable {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userName=" + "$userName" + ", ");
    buffer.write("Password=" + "$Password");
    buffer.write("}");

    return buffer.toString();
  }

  LoginTable copyWith(
      {String id,
      String userName,
      String Password,
      List<DeckListTable> DeckListTables,
      List<CardsListTable> CardsListTables}) {
    return LoginTable(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        Password: Password ?? this.Password,
        DeckListTables: DeckListTables ?? this.DeckListTables,
        CardsListTables: CardsListTables ?? this.CardsListTables);
  }

  LoginTable.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        Password = json['Password'],
        DeckListTables = json['DeckListTables'] is List
            ? (json['DeckListTables'] as List)
                .map((e) =>
                    DeckListTable.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        CardsListTables = json['CardsListTables'] is List
            ? (json['CardsListTables'] as List)
                .map((e) =>
                    CardsListTable.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'Password': Password,
        'DeckListTables': DeckListTables?.map((e) => e?.toJson())?.toList(),
        'CardsListTables': CardsListTables?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "loginTable.id");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField PASSWORD = QueryField(fieldName: "Password");
  static final QueryField DECKLISTTABLES = QueryField(
      fieldName: "DeckListTables",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (DeckListTable).toString()));
  static final QueryField CARDSLISTTABLES = QueryField(
      fieldName: "CardsListTables",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (CardsListTable).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LoginTable";
    modelSchemaDefinition.pluralName = "LoginTables";

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
        key: LoginTable.USERNAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LoginTable.PASSWORD,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: LoginTable.DECKLISTTABLES,
        isRequired: false,
        ofModelName: (DeckListTable).toString(),
        associatedKey: DeckListTable.LOGINTABLEID));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: LoginTable.CARDSLISTTABLES,
        isRequired: false,
        ofModelName: (CardsListTable).toString(),
        associatedKey: CardsListTable.LOGINTABLEID));
  });
}

class _LoginTableModelType extends ModelType<LoginTable> {
  const _LoginTableModelType();

  @override
  LoginTable fromJson(Map<String, dynamic> jsonData) {
    return LoginTable.fromJson(jsonData);
  }
}
