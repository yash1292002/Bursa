// To parse this JSON data, do
//
//     final companiesData = companiesDataFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

CompaniesData companiesDataFromJson(String str) =>
    CompaniesData.fromJson(json.decode(str));

String companiesDataToJson(CompaniesData data) => json.encode(data.toJson());

class CompaniesData {
  CompaniesData({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<ComapaniesInfo>? returnData;
  bool? returnStatus;

  factory CompaniesData.fromJson(Map<String, dynamic> json) => CompaniesData(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<ComapaniesInfo>.from(
                json["returnData"].map((x) => ComapaniesInfo.fromJson(x))),
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

class ComapaniesInfo {
  ComapaniesInfo({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory ComapaniesInfo.fromJson(Map<String, dynamic> json) => ComapaniesInfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
