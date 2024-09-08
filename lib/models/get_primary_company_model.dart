// To parse this JSON data, do
//
//     final primaryCompany = primaryCompanyFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

PrimaryCompany primaryCompanyFromJson(String str) =>
    PrimaryCompany.fromJson(json.decode(str));

String primaryCompanyToJson(PrimaryCompany data) => json.encode(data.toJson());

class PrimaryCompany {
  PrimaryCompany({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<PrimaryCompanyInfo>? returnData;
  bool? returnStatus;

  factory PrimaryCompany.fromJson(Map<String, dynamic> json) => PrimaryCompany(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<PrimaryCompanyInfo>.from(
                json["returnData"].map((x) => PrimaryCompanyInfo.fromJson(x))),
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

class PrimaryCompanyInfo {
  PrimaryCompanyInfo({
    this.companyId,
    this.companyName,
    this.investorDto,
    this.companyInfo,
    this.webView,
  });

  int? companyId;
  String? companyName;
  List<dynamic>? investorDto;
  List<CompanyInfo>? companyInfo;
  List<CompanyInfo>? webView;

  factory PrimaryCompanyInfo.fromJson(Map<String, dynamic> json) =>
      PrimaryCompanyInfo(
        companyId: json["companyId"] == null ? null : json["companyId"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        investorDto: json["investorDto"] == null
            ? null
            : List<dynamic>.from(json["investorDto"].map((x) => x)),
        companyInfo: json["companyInfo"] == null
            ? null
            : List<CompanyInfo>.from(
                json["companyInfo"].map((x) => CompanyInfo.fromJson(x))),
        webView: json["webView"] == null
            ? null
            : List<CompanyInfo>.from(
                json["webView"].map((x) => CompanyInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "companyId": companyId == null ? null : companyId,
        "companyName": companyName == null ? null : companyName,
        "investorDto": investorDto == null
            ? null
            : List<dynamic>.from(investorDto!.map((x) => x)),
        "companyInfo": companyInfo == null
            ? null
            : List<dynamic>.from(companyInfo!.map((x) => x.toJson())),
        "webView": webView == null
            ? null
            : List<dynamic>.from(webView!.map((x) => x.toJson())),
      };
}

class CompanyInfo {
  CompanyInfo({
    this.id,
    this.name,
    this.value,
  });

  int? id;
  String? name;
  String? value;

  factory CompanyInfo.fromJson(Map<String, dynamic> json) => CompanyInfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "value": value == null ? null : value,
      };
}
