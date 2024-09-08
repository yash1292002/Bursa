// To parse this JSON data, do
//
//     final nationalitiesData = nationalitiesDataFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

NationalitiesData nationalitiesDataFromJson(String str) =>
    NationalitiesData.fromJson(json.decode(str));

String nationalitiesDataToJson(NationalitiesData data) =>
    json.encode(data.toJson());

class NationalitiesData {
  NationalitiesData({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<NationalityInfo>? returnData;
  bool? returnStatus;

  factory NationalitiesData.fromJson(Map<String, dynamic> json) =>
      NationalitiesData(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<NationalityInfo>.from(
                json["returnData"].map((x) => NationalityInfo.fromJson(x))),
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

class NationalityInfo {
  NationalityInfo({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory NationalityInfo.fromJson(Map<String, dynamic> json) =>
      NationalityInfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
