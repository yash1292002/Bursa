// To parse this JSON data, do
//
//     final paymentDetails = paymentDetailsFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

PaymentDetails paymentDetailsFromJson(String str) =>
    PaymentDetails.fromJson(json.decode(str));

String paymentDetailsToJson(PaymentDetails data) => json.encode(data.toJson());

class PaymentDetails {
  PaymentDetails({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<PaymentInfo>? returnData;
  bool? returnStatus;

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<PaymentInfo>.from(
                json["returnData"].map((x) => PaymentInfo.fromJson(x))),
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

class PaymentInfo {
  PaymentInfo({
    this.id,
    this.offeredShareId,
    this.paymentType,
    this.transactionId,
    this.companyName,
  });

  int? id;
  int? offeredShareId;
  String? paymentType;
  String? transactionId;
  String? companyName;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        id: json["id"] == null ? null : json["id"],
        offeredShareId:
            json["offeredShareId"] == null ? null : json["offeredShareId"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        transactionId:
            json["transactionId"] == null ? null : json["transactionId"],
        companyName: json["companyName"] == null ? null : json["companyName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "offeredShareId": offeredShareId == null ? null : offeredShareId,
        "paymentType": paymentType == null ? null : paymentType,
        "transactionId": transactionId == null ? null : transactionId,
        "companyName": companyName == null ? null : companyName,
      };
}
