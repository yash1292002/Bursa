// To parse this JSON data, do
//
//     final grantTypeData = grantTypeDataFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

GrantTypeData grantTypeDataFromJson(String str) =>
    GrantTypeData.fromJson(json.decode(str));

String grantTypeDataToJson(GrantTypeData data) => json.encode(data.toJson());

class GrantTypeData {
  GrantTypeData({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<GrantTypeInfo>? returnData;
  bool? returnStatus;

  factory GrantTypeData.fromJson(Map<String, dynamic> json) => GrantTypeData(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<GrantTypeInfo>.from(
                json["returnData"].map((x) => GrantTypeInfo.fromJson(x))),
        returnStatus:
            json["returnStatus"] == null ? null : json["returnStatus"],
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode == null ? null : returnCode,
        "returnMessage": returnMessage == null ? null : returnMessage,
        "returnData": returnData == null
            ? null
            : List<dynamic>.from(returnData!.map((x) => x.toJson())),
        "returnStatus": returnStatus == null ? null : returnStatus,
      };
}

class GrantTypeInfo {
  GrantTypeInfo({
    this.id,
    this.name,
    this.description,
  });

  int? id;
  String? name;
  String? description;

  factory GrantTypeInfo.fromJson(Map<String, dynamic> json) => GrantTypeInfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
      };
}
