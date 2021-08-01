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

/** This is an auto generated class representing the DeckListTable type in your schema. */
@immutable
class DeckListTable extends Model {
  static const classType = const _DeckListTableModelType();
  final String id;
  final String deckName;
  final List<CardsListTable> CardsLists;
  final List<ChartListTable> ChartDeckList;
  final String logintableID;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const DeckListTable._internal(
      {@required this.id,
      this.deckName,
      this.CardsLists,
      this.ChartDeckList,
      this.logintableID});

  factory DeckListTable(
      {String id,
      String deckName,
      List<CardsListTable> CardsLists,
      List<ChartListTable> ChartDeckList,
      String logintableID}) {
    return DeckListTable._internal(
        id: id == null ? UUID.getUUID() : id,
        deckName: deckName,
        CardsLists: CardsLists != null
            ? List<CardsListTable>.unmodifiable(CardsLists)
            : CardsLists,
        ChartDeckList: ChartDeckList != null
            ? List<ChartListTable>.unmodifiable(ChartDeckList)
            : ChartDeckList,
        logintableID: logintableID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeckListTable &&
        id == other.id &&
        deckName == other.deckName &&
        DeepCollectionEquality().equals(CardsLists, other.CardsLists) &&
        DeepCollectionEquality().equals(ChartDeckList, other.ChartDeckList) &&
        logintableID == other.logintableID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("DeckListTable {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("deckName=" + "$deckName" + ", ");
    buffer.write("logintableID=" + "$logintableID");
    buffer.write("}");

    return buffer.toString();
  }

  DeckListTable copyWith(
      {String id,
      String deckName,
      List<CardsListTable> CardsLists,
      List<ChartListTable> ChartDeckList,
      String logintableID}) {
    return DeckListTable(
        id: id ?? this.id,
        deckName: deckName ?? this.deckName,
        CardsLists: CardsLists ?? this.CardsLists,
        ChartDeckList: ChartDeckList ?? this.ChartDeckList,
        logintableID: logintableID ?? this.logintableID);
  }

  DeckListTable.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deckName = json['deckName'],
        CardsLists = json['CardsLists'] is List
            ? (json['CardsLists'] as List)
                .map((e) =>
                    CardsListTable.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        ChartDeckList = json['ChartDeckList'] is List
            ? (json['ChartDeckList'] as List)
                .map((e) =>
                    ChartListTable.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        logintableID = json['logintableID'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'deckName': deckName,
        'CardsLists': CardsLists?.map((e) => e?.toJson())?.toList(),
        'ChartDeckList': ChartDeckList?.map((e) => e?.toJson())?.toList(),
        'logintableID': logintableID
      };

  static final QueryField ID = QueryField(fieldName: "deckListTable.id");
  static final QueryField DECKNAME = QueryField(fieldName: "deckName");
  static final QueryField CARDSLISTS = QueryField(
      fieldName: "CardsLists",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (CardsListTable).toString()));
  static final QueryField CHARTDECKLIST = QueryField(
      fieldName: "ChartDeckList",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (ChartListTable).toString()));
  static final QueryField LOGINTABLEID = QueryField(fieldName: "logintableID");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "DeckListTable";
    modelSchemaDefinition.pluralName = "DeckListTables";

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
        key: DeckListTable.DECKNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: DeckListTable.CARDSLISTS,
        isRequired: false,
        ofModelName: (CardsListTable).toString(),
        associatedKey: CardsListTable.DECKLISTTABLEID));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: DeckListTable.CHARTDECKLIST,
        isRequired: false,
        ofModelName: (ChartListTable).toString(),
        associatedKey: ChartListTable.DECKLISTTABLEID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: DeckListTable.LOGINTABLEID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _DeckListTableModelType extends ModelType<DeckListTable> {
  const _DeckListTableModelType();

  @override
  DeckListTable fromJson(Map<String, dynamic> jsonData) {
    return DeckListTable.fromJson(jsonData);
  }
}
