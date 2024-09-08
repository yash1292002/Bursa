// To parse this JSON data, do
//
//     final employementData = employementDataFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

EmployementData employementDataFromJson(String str) =>
    EmployementData.fromJson(json.decode(str));

String employementDataToJson(EmployementData data) =>
    json.encode(data.toJson());

class EmployementData {
  EmployementData({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<EmployementInfo>? returnData;
  bool? returnStatus;

  factory EmployementData.fromJson(Map<String, dynamic> json) =>
      EmployementData(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<EmployementInfo>.from(
                json["returnData"].map((x) => EmployementInfo.fromJson(x))),
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

class EmployementInfo {
  EmployementInfo({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory EmployementInfo.fromJson(Map<String, dynamic> json) =>
      EmployementInfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
