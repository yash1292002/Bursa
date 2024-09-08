// To parse this JSON data, do
//
//     final issueCertificate = issueCertificateFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

IssueCertificate issueCertificateFromJson(String str) =>
    IssueCertificate.fromJson(json.decode(str));

String issueCertificateToJson(IssueCertificate data) =>
    json.encode(data.toJson());

class IssueCertificate {
  IssueCertificate({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  ReturnData? returnData;
  bool? returnStatus;

  factory IssueCertificate.fromJson(Map<String, dynamic> json) =>
      IssueCertificate(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : ReturnData.fromJson(json["returnData"]),
        returnStatus:
            json["returnStatus"] == null ? null : json["returnStatus"],
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode == null ? null : returnCode,
        "returnMessage": returnMessage == null ? null : returnMessage,
        "returnData": returnData == null ? null : returnData!.toJson(),
        "returnStatus": returnStatus == null ? null : returnStatus,
      };
}

class ReturnData {
  ReturnData({
    this.certificateImageUrl,
    this.certificateKey,
  });

  String? certificateImageUrl;
  String? certificateKey;

  factory ReturnData.fromJson(Map<String, dynamic> json) => ReturnData(
        certificateImageUrl: json["CertificateImageUrl"] == null
            ? null
            : json["CertificateImageUrl"],
        certificateKey:
            json["CertificateKey"] == null ? null : json["CertificateKey"],
      );

  Map<String, dynamic> toJson() => {
        "CertificateImageUrl":
            certificateImageUrl == null ? null : certificateImageUrl,
        "CertificateKey": certificateKey == null ? null : certificateKey,
      };
}
