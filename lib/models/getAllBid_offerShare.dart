// import 'dart:convert';

// BidPrimaryOfferData bidPrimaryOfferDataFromJson(String str) =>
//     BidPrimaryOfferData.fromJson(json.decode(str));

// String bidPrimaryOfferDataToJson(BidPrimaryOfferData data) =>
//     json.encode(data.toJson());

// class BidPrimaryOfferData {
//   BidPrimaryOfferData({
//     this.returnCode,
//     this.returnMessage,
//     this.returnData,
//     this.returnStatus,
//   });

//   int? returnCode;
//   String? returnMessage;
//   List<BidPrimaryOfferDataInfo>? returnData;
//   bool? returnStatus;

//   factory BidPrimaryOfferData.fromJson(Map<String, dynamic> json) =>
//       BidPrimaryOfferData(
//         returnCode: json["returnCode"] == null ? null : json["returnCode"],
//         returnMessage:
//             json["returnMessage"] == null ? null : json["returnMessage"],
//         returnData: json["returnData"] == null
//             ? null
//             : List<BidPrimaryOfferDataInfo>.from(json["returnData"]
//                 .map((x) => BidPrimaryOfferDataInfo.fromJson(x))),
//         returnStatus:
//             json["returnStatus"] == null ? null : json["returnStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "returnCode": returnCode == null ? null : returnCode,
//         "returnMessage": returnMessage == null ? null : returnMessage,
//         "returnData": returnData == null
//             ? null
//             : List<dynamic>.from(returnData!.map((x) => x.toJson())),
//         "returnStatus": returnStatus == null ? null : returnStatus,
//       };
// }

// class BidPrimaryOfferDataInfo {
//   BidPrimaryOfferDataInfo({
//     this.id,
//     this.companyName,
//     this.userLoginId,
//     this.paymentType,
//     this.verificationStatus,
//     this.placementAmount,
//     this.isESign,
//     this.isDownload,
//     this.transactionId,
//     this.approvedOn,
//   });

//   int? id;
//   String? companyName;
//   int? userLoginId;
//   String? paymentType;
//   String? verificationStatus;
//   double? placementAmount;
//   bool? isESign;
//   bool? isDownload;
//   String? transactionId;
//   String? approvedOn;

//   factory BidPrimaryOfferDataInfo.fromJson(Map<String, dynamic> json) =>
//       BidPrimaryOfferDataInfo(
//         id: json["id"] == null ? null : json["id"],
//         companyName: json["companyName"] == null ? null : json["companyName"],
//         userLoginId: json["userLoginId"] == null ? null : json["userLoginId"],
//         paymentType: json["paymentType"] == null ? null : json["paymentType"],
//         verificationStatus: json["verificationStatus"] == null
//             ? null
//             : json["verificationStatus"],
//         placementAmount: json["placementAmount"] == null
//             ? null
//             : json["placementAmount"].toDouble(),
//         isESign: json["isESign"] == null ? null : json["isESign"],
//         isDownload: json["isDownload"] == null ? null : json["isDownload"],
//         transactionId:
//             json["transactionId"] == null ? null : json["transactionId"],
//         approvedOn: json["approvedOn"] == null ? null : json["approvedOn"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "companyName": companyName == null ? null : companyName,
//         "userLoginId": userLoginId == null ? null : userLoginId,
//         "paymentType": paymentType == null ? null : paymentType,
//         "verificationStatus":
//             verificationStatus == null ? null : verificationStatus,
//         "placementAmount": placementAmount == null ? null : placementAmount,
//         "isESign": isESign == null ? null : isESign,
//         "isDownload": isDownload == null ? null : isDownload,
//         "transactionId": transactionId == null ? null : transactionId,
//         "approvedOn": approvedOn == null ? null : approvedOn,
//       };
// }
// To parse this JSON data, do
//
//     final bidPrimaryOfferData = bidPrimaryOfferDataFromJson(jsonString);

import 'dart:convert';

BidPrimaryOfferData bidPrimaryOfferDataFromJson(String str) =>
    BidPrimaryOfferData.fromJson(json.decode(str));

String bidPrimaryOfferDataToJson(BidPrimaryOfferData data) =>
    json.encode(data.toJson());

class BidPrimaryOfferData {
  BidPrimaryOfferData({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<BidPrimaryOfferDataInfo>? returnData;
  bool? returnStatus;

  factory BidPrimaryOfferData.fromJson(Map<String, dynamic> json) =>
      BidPrimaryOfferData(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<BidPrimaryOfferDataInfo>.from(json["returnData"]
                .map((x) => BidPrimaryOfferDataInfo.fromJson(x))),
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

class BidPrimaryOfferDataInfo {
  BidPrimaryOfferDataInfo({
    this.id,
    this.companyName,
    this.userLoginId,
    this.paymentType,
    this.verificationStatus,
    this.placementAmount,
    this.busraFees,
    this.isESign,
    this.isDownload,
    this.transactionId,
    this.approvedOn,
  });

  int? id;
  String? companyName;
  int? userLoginId;
  String? paymentType;
  String? verificationStatus;
  int? placementAmount;
  double? busraFees;
  bool? isESign;
  bool? isDownload;
  String? transactionId;
  String? approvedOn;

  factory BidPrimaryOfferDataInfo.fromJson(Map<String, dynamic> json) =>
      BidPrimaryOfferDataInfo(
        id: json["id"] == null ? null : json["id"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        userLoginId: json["userLoginId"] == null ? null : json["userLoginId"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        verificationStatus: json["verificationStatus"] == null
            ? null
            : json["verificationStatus"],
        placementAmount:
            json["placementAmount"] == null ? null : json["placementAmount"],
        busraFees:
            json["busraFees"] == null ? null : json["busraFees"].toDouble(),
        isESign: json["isESign"] == null ? null : json["isESign"],
        isDownload: json["isDownload"] == null ? null : json["isDownload"],
        transactionId:
            json["transactionId"] == null ? null : json["transactionId"],
        approvedOn: json["approvedOn"] == null ? null : json["approvedOn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "companyName": companyName == null ? null : companyName,
        "userLoginId": userLoginId == null ? null : userLoginId,
        "paymentType": paymentType == null ? null : paymentType,
        "verificationStatus":
            verificationStatus == null ? null : verificationStatus,
        "placementAmount": placementAmount == null ? null : placementAmount,
        "busraFees": busraFees == null ? null : busraFees,
        "isESign": isESign == null ? null : isESign,
        "isDownload": isDownload == null ? null : isDownload,
        "transactionId": transactionId == null ? null : transactionId,
        "approvedOn": approvedOn == null ? null : approvedOn,
      };
}
