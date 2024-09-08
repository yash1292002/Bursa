// To parse this JSON data, do
//
//     final paymentType = paymentTypeFromJson(jsonString);

import 'dart:convert';

PaymentType paymentTypeFromJson(String str) =>
    PaymentType.fromJson(json.decode(str));

String paymentTypeToJson(PaymentType data) => json.encode(data.toJson());

class PaymentType {
  PaymentType({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<PaymentTypeInfo>? returnData;
  bool? returnStatus;

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<PaymentTypeInfo>.from(
                json["returnData"].map((x) => PaymentTypeInfo.fromJson(x))),
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

class PaymentTypeInfo {
  PaymentTypeInfo({
    this.id,
    this.value,
  });

  int? id;
  String? value;

  factory PaymentTypeInfo.fromJson(Map<String, dynamic> json) =>
      PaymentTypeInfo(
        id: json["id"] == null ? null : json["id"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "value": value == null ? null : value,
      };
}
