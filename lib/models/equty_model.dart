// To parse this JSON data, do
//
//     final equityRounds = equityRoundsFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

EquityRounds equityRoundsFromJson(String str) =>
    EquityRounds.fromJson(json.decode(str));

String equityRoundsToJson(EquityRounds data) => json.encode(data.toJson());

class EquityRounds {
  EquityRounds({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<EquityRoundsInfo>? returnData;
  bool? returnStatus;

  factory EquityRounds.fromJson(Map<String, dynamic> json) => EquityRounds(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<EquityRoundsInfo>.from(
                json["returnData"].map((x) => EquityRoundsInfo.fromJson(x))),
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

class EquityRoundsInfo {
  EquityRoundsInfo({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory EquityRoundsInfo.fromJson(Map<String, dynamic> json) =>
      EquityRoundsInfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
