// To parse this JSON data, do
//
//     final offerShareInfo = offerShareInfoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

OfferShareInfo offerShareInfoFromJson(String str) =>
    OfferShareInfo.fromJson(json.decode(str));

String offerShareInfoToJson(OfferShareInfo data) => json.encode(data.toJson());

class OfferShareInfo {
  OfferShareInfo({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<OfferShareDetails>? returnData;
  bool? returnStatus;

  factory OfferShareInfo.fromJson(Map<String, dynamic> json) => OfferShareInfo(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<OfferShareDetails>.from(
                json["returnData"].map((x) => OfferShareDetails.fromJson(x))),
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

class OfferShareDetails {
  OfferShareDetails({
    this.id,
    this.companyName,
    this.numberOfShares,
    this.sharePrice,
  });

  int? id;
  String? companyName;
  int? numberOfShares;
  int? sharePrice;

  factory OfferShareDetails.fromJson(Map<String, dynamic> json) =>
      OfferShareDetails(
        id: json["Id"] == null ? null : json["Id"],
        companyName: json["CompanyName"] == null ? null : json["CompanyName"],
        numberOfShares:
            json["NumberOfShares"] == null ? null : json["NumberOfShares"],
        sharePrice: json["SharePrice"] == null ? null : json["SharePrice"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id == null ? null : id,
        "CompanyName": companyName == null ? null : companyName,
        "NumberOfShares": numberOfShares == null ? null : numberOfShares,
        "SharePrice": sharePrice == null ? null : sharePrice,
      };
}
