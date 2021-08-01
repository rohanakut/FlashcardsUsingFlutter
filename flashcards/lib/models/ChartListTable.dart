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

/** This is an auto generated class representing the ChartListTable type in your schema. */
@immutable
class ChartListTable extends Model {
  static const classType = const _ChartListTableModelType();
  final String id;
  final int good;
  final int ok;
  final int bad;
  final double percentage;
  final String decklisttableID;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const ChartListTable._internal(
      {@required this.id,
      this.good,
      this.ok,
      this.bad,
      this.percentage,
      this.decklisttableID});

  factory ChartListTable(
      {String id,
      int good,
      int ok,
      int bad,
      double percentage,
      String decklisttableID}) {
    return ChartListTable._internal(
        id: id == null ? UUID.getUUID() : id,
        good: good,
        ok: ok,
        bad: bad,
        percentage: percentage,
        decklisttableID: decklisttableID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChartListTable &&
        id == other.id &&
        good == other.good &&
        ok == other.ok &&
        bad == other.bad &&
        percentage == other.percentage &&
        decklisttableID == other.decklisttableID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ChartListTable {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("good=" + (good != null ? good.toString() : "null") + ", ");
    buffer.write("ok=" + (ok != null ? ok.toString() : "null") + ", ");
    buffer.write("bad=" + (bad != null ? bad.toString() : "null") + ", ");
    buffer.write("percentage=" +
        (percentage != null ? percentage.toString() : "null") +
        ", ");
    buffer.write("decklisttableID=" + "$decklisttableID");
    buffer.write("}");

    return buffer.toString();
  }

  ChartListTable copyWith(
      {String id,
      int good,
      int ok,
      int bad,
      double percentage,
      String decklisttableID}) {
    return ChartListTable(
        id: id ?? this.id,
        good: good ?? this.good,
        ok: ok ?? this.ok,
        bad: bad ?? this.bad,
        percentage: percentage ?? this.percentage,
        decklisttableID: decklisttableID ?? this.decklisttableID);
  }

  ChartListTable.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        good = json['good'],
        ok = json['ok'],
        bad = json['bad'],
        percentage = json['percentage'],
        decklisttableID = json['decklisttableID'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'good': good,
        'ok': ok,
        'bad': bad,
        'percentage': percentage,
        'decklisttableID': decklisttableID
      };

  static final QueryField ID = QueryField(fieldName: "chartListTable.id");
  static final QueryField GOOD = QueryField(fieldName: "good");
  static final QueryField OK = QueryField(fieldName: "ok");
  static final QueryField BAD = QueryField(fieldName: "bad");
  static final QueryField PERCENTAGE = QueryField(fieldName: "percentage");
  static final QueryField DECKLISTTABLEID =
      QueryField(fieldName: "decklisttableID");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ChartListTable";
    modelSchemaDefinition.pluralName = "ChartListTables";

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
        key: ChartListTable.GOOD,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ChartListTable.OK,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ChartListTable.BAD,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ChartListTable.PERCENTAGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ChartListTable.DECKLISTTABLEID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _ChartListTableModelType extends ModelType<ChartListTable> {
  const _ChartListTableModelType();

  @override
  ChartListTable fromJson(Map<String, dynamic> jsonData) {
    return ChartListTable.fromJson(jsonData);
  }
}
