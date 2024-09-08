// To parse this JSON data, do
//
//     final issueShare = issueShareFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

IssueShare issueShareFromJson(String str) =>
    IssueShare.fromJson(json.decode(str));

String issueShareToJson(IssueShare data) => json.encode(data.toJson());

class IssueShare {
  IssueShare({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<IssueShareInfo>? returnData;
  bool? returnStatus;

  factory IssueShare.fromJson(Map<String, dynamic> json) => IssueShare(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<IssueShareInfo>.from(
                json["returnData"].map((x) => IssueShareInfo.fromJson(x))),
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

class IssueShareInfo {
  IssueShareInfo({
    this.id,
    this.shareId,
    this.firstName,
    this.lastName,
    this.middleName,
    this.dateOfBirth,
    this.companyName,
    this.numberOfShares,
    this.isCertified,
    this.certificateUrl,
    this.certificateKey,
  });

  int? id;
  int? shareId;
  String? firstName;
  String? lastName;
  String? middleName;
  DateTime? dateOfBirth;
  String? companyName;
  int? numberOfShares;
  bool? isCertified;
  String? certificateUrl;
  String? certificateKey;

  factory IssueShareInfo.fromJson(Map<String, dynamic> json) => IssueShareInfo(
        id: json["id"] == null ? null : json["id"],
        shareId: json["shareId"] == null ? null : json["shareId"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        middleName: json["middleName"] == null ? null : json["middleName"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        companyName: json["companyName"] == null ? null : json["companyName"],
        numberOfShares:
            json["numberOfShares"] == null ? null : json["numberOfShares"],
        isCertified: json["isCertified"] == null ? null : json["isCertified"],
        certificateUrl:
            json["certificateUrl"] == null ? null : json["certificateUrl"],
        certificateKey:
            json["certificateKey"] == null ? null : json["certificateKey"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "shareId": shareId == null ? null : shareId,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "middleName": middleName == null ? null : middleName,
        "dateOfBirth": dateOfBirth == null
            ? null
            : "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "companyName": companyName == null ? null : companyName,
        "numberOfShares": numberOfShares == null ? null : numberOfShares,
        "isCertified": isCertified == null ? null : isCertified,
        "certificateUrl": certificateUrl == null ? null : certificateUrl,
        "certificateKey": certificateKey == null ? null : certificateKey,
      };
}
