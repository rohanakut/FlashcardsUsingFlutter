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

/** This is an auto generated class representing the CardsListTable type in your schema. */
@immutable
class CardsListTable extends Model {
  static const classType = const _CardsListTableModelType();
  final String id;
  final String question;
  final String answer;
  final int confidence;
  final String logintableID;
  final String decklisttableID;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const CardsListTable._internal(
      {@required this.id,
      this.question,
      this.answer,
      this.confidence,
      this.logintableID,
      this.decklisttableID});

  factory CardsListTable(
      {String id,
      String question,
      String answer,
      int confidence,
      String logintableID,
      String decklisttableID}) {
    return CardsListTable._internal(
        id: id == null ? UUID.getUUID() : id,
        question: question,
        answer: answer,
        confidence: confidence,
        logintableID: logintableID,
        decklisttableID: decklisttableID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CardsListTable &&
        id == other.id &&
        question == other.question &&
        answer == other.answer &&
        confidence == other.confidence &&
        logintableID == other.logintableID &&
        decklisttableID == other.decklisttableID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("CardsListTable {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("question=" + "$question" + ", ");
    buffer.write("answer=" + "$answer" + ", ");
    buffer.write("confidence=" +
        (confidence != null ? confidence.toString() : "null") +
        ", ");
    buffer.write("logintableID=" + "$logintableID" + ", ");
    buffer.write("decklisttableID=" + "$decklisttableID");
    buffer.write("}");

    return buffer.toString();
  }

  CardsListTable copyWith(
      {String id,
      String question,
      String answer,
      int confidence,
      String logintableID,
      String decklisttableID}) {
    return CardsListTable(
        id: id ?? this.id,
        question: question ?? this.question,
        answer: answer ?? this.answer,
        confidence: confidence ?? this.confidence,
        logintableID: logintableID ?? this.logintableID,
        decklisttableID: decklisttableID ?? this.decklisttableID);
  }

  CardsListTable.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answer = json['answer'],
        confidence = json['confidence'],
        logintableID = json['logintableID'],
        decklisttableID = json['decklisttableID'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'answer': answer,
        'confidence': confidence,
        'logintableID': logintableID,
        'decklisttableID': decklisttableID
      };

  static final QueryField ID = QueryField(fieldName: "cardsListTable.id");
  static final QueryField QUESTION = QueryField(fieldName: "question");
  static final QueryField ANSWER = QueryField(fieldName: "answer");
  static final QueryField CONFIDENCE = QueryField(fieldName: "confidence");
  static final QueryField LOGINTABLEID = QueryField(fieldName: "logintableID");
  static final QueryField DECKLISTTABLEID =
      QueryField(fieldName: "decklisttableID");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CardsListTable";
    modelSchemaDefinition.pluralName = "CardsListTables";

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
        key: CardsListTable.QUESTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CardsListTable.ANSWER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CardsListTable.CONFIDENCE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CardsListTable.LOGINTABLEID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CardsListTable.DECKLISTTABLEID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _CardsListTableModelType extends ModelType<CardsListTable> {
  const _CardsListTableModelType();

  @override
  CardsListTable fromJson(Map<String, dynamic> jsonData) {
    return CardsListTable.fromJson(jsonData);
  }
}
