// To parse this JSON data, do
//
//     final debtRounds = debtRoundsFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

DebtRounds debtRoundsFromJson(String str) =>
    DebtRounds.fromJson(json.decode(str));

String debtRoundsToJson(DebtRounds data) => json.encode(data.toJson());

class DebtRounds {
  DebtRounds({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<DebtRoundInfo>? returnData;
  bool? returnStatus;

  factory DebtRounds.fromJson(Map<String, dynamic> json) => DebtRounds(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<DebtRoundInfo>.from(
                json["returnData"].map((x) => DebtRoundInfo.fromJson(x))),
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

class DebtRoundInfo {
  DebtRoundInfo({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory DebtRoundInfo.fromJson(Map<String, dynamic> json) => DebtRoundInfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
