// To parse this JSON data, do
//
//     final limitInfo = limitInfoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

LimitInfo limitInfoFromJson(String str) => LimitInfo.fromJson(json.decode(str));

String limitInfoToJson(LimitInfo data) => json.encode(data.toJson());

class LimitInfo {
  LimitInfo({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<LimitDetails>? returnData;
  bool? returnStatus;

  factory LimitInfo.fromJson(Map<String, dynamic> json) => LimitInfo(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<LimitDetails>.from(
                json["returnData"].map((x) => LimitDetails.fromJson(x))),
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

class LimitDetails {
  LimitDetails({
    this.id,
    this.value,
  });

  int? id;
  String? value;

  factory LimitDetails.fromJson(Map<String, dynamic> json) => LimitDetails(
        id: json["id"] == null ? null : json["id"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "value": value == null ? null : value,
      };
}
