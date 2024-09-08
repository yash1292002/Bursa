// // To parse this JSON data, do
// //
// //     final bidShareInfo = bidShareInfoFromJson(jsonString);

// import 'dart:convert';

// BidShareInfo bidShareInfoFromJson(String str) =>
//     BidShareInfo.fromJson(json.decode(str));

// String bidShareInfoToJson(BidShareInfo data) => json.encode(data.toJson());

// class BidShareInfo {
//   BidShareInfo({
//     this.returnCode,
//     this.returnMessage,
//     this.returnData,
//     this.returnStatus,
//   });

//   int? returnCode;
//   String? returnMessage;
//   List<BidShareDetails>? returnData;
//   bool? returnStatus;

//   factory BidShareInfo.fromJson(Map<String, dynamic> json) => BidShareInfo(
//         returnCode: json["returnCode"] == null ? null : json["returnCode"],
//         returnMessage:
//             json["returnMessage"] == null ? null : json["returnMessage"],
//         returnData: json["returnData"] == null
//             ? null
//             : List<BidShareDetails>.from(
//                 json["returnData"].map((x) => BidShareDetails.fromJson(x))),
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

// class BidShareDetails {
//   BidShareDetails({
//     this.id,
//     this.quantity,
//     this.maximumBidPrice,
//     this.minimumBidPrice,
//     this.paymentType,
//     this.offeredShareId,
//     this.verificationState,
//     this.companyName,
//     this.businessLogo,
//     this.lostValuation,
//     this.addedDate,
//     this.userLoginId,
//   });

//   int? id;
//   int? quantity;
//   int? maximumBidPrice;
//   int? minimumBidPrice;
//   String? paymentType;
//   int? offeredShareId;
//   String? verificationState;
//   String? companyName;
//   String? businessLogo;
//   String? lostValuation;
//   String? addedDate;
//   int? userLoginId;

//   factory BidShareDetails.fromJson(Map<String, dynamic> json) =>
//       BidShareDetails(
//         id: json["id"] == null ? null : json["id"],
//         quantity: json["quantity"] == null ? null : json["quantity"],
//         maximumBidPrice:
//             json["maximumBidPrice"] == null ? null : json["maximumBidPrice"],
//         minimumBidPrice:
//             json["minimumBidPrice"] == null ? null : json["minimumBidPrice"],
//         paymentType: json["paymentType"] == null ? null : json["paymentType"],
//         offeredShareId:
//             json["offeredShareId"] == null ? null : json["offeredShareId"],
//         verificationState: json["verificationState"] == null
//             ? null
//             : json["verificationState"],
//         companyName: json["companyName"] == null ? null : json["companyName"],
//         businessLogo:
//             json["businessLogo"] == null ? null : json["businessLogo"],
//         lostValuation:
//             json["lostValuation"] == null ? null : json["lostValuation"],
//         addedDate: json["addedDate"] == null ? null : json["addedDate"],
//         userLoginId: json["userLoginId"] == null ? null : json["userLoginId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "quantity": quantity == null ? null : quantity,
//         "maximumBidPrice": maximumBidPrice == null ? null : maximumBidPrice,
//         "minimumBidPrice": minimumBidPrice == null ? null : minimumBidPrice,
//         "paymentType": paymentType == null ? null : paymentType,
//         "offeredShareId": offeredShareId == null ? null : offeredShareId,
//         "verificationState":
//             verificationState == null ? null : verificationState,
//         "companyName": companyName == null ? null : companyName,
//         "businessLogo": businessLogo == null ? null : businessLogo,
//         "lostValuation": lostValuation == null ? null : lostValuation,
//         "addedDate": addedDate == null ? null : addedDate,
//         "userLoginId": userLoginId == null ? null : userLoginId,
//       };
// }

// To parse this JSON data, do
//
//     final bidShareInfo = bidShareInfoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

BidShareInfo bidShareInfoFromJson(String str) =>
    BidShareInfo.fromJson(json.decode(str));

String bidShareInfoToJson(BidShareInfo data) => json.encode(data.toJson());

class BidShareInfo {
  BidShareInfo({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<BidShareDetails>? returnData;
  bool? returnStatus;

  factory BidShareInfo.fromJson(Map<String, dynamic> json) => BidShareInfo(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<BidShareDetails>.from(
                json["returnData"].map((x) => BidShareDetails.fromJson(x))),
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

class BidShareDetails {
  BidShareDetails({
    this.id,
    this.quantity,
    this.maximumBidPrice,
    this.minimumBidPrice,
    this.paymentType,
    this.offeredShareId,
    this.offerTimeLimit,
    this.offerType,
    this.verificationState,
    this.companyName,
    this.businessLogo,
    this.lostValuation,
    this.addedDate,
    this.userLoginId,
  });

  int? id;
  int? quantity;
  int? maximumBidPrice;
  int? minimumBidPrice;
  String? paymentType;
  int? offeredShareId;
  String? offerTimeLimit;
  String? offerType;
  String? verificationState;
  String? companyName;
  String? businessLogo;
  String? lostValuation;
  String? addedDate;
  int? userLoginId;

  factory BidShareDetails.fromJson(Map<String, dynamic> json) =>
      BidShareDetails(
        id: json["id"] == null ? null : json["id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        maximumBidPrice:
            json["maximumBidPrice"] == null ? null : json["maximumBidPrice"],
        minimumBidPrice:
            json["minimumBidPrice"] == null ? null : json["minimumBidPrice"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        offeredShareId:
            json["offeredShareId"] == null ? null : json["offeredShareId"],
        offerTimeLimit:
            json["offerTimeLimit"] == null ? null : json["offerTimeLimit"],
        offerType: json["offerType"] == null ? null : json["offerType"],
        verificationState: json["verificationState"] == null
            ? null
            : json["verificationState"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        businessLogo:
            json["businessLogo"] == null ? null : json["businessLogo"],
        lostValuation:
            json["lostValuation"] == null ? null : json["lostValuation"],
        addedDate: json["addedDate"] == null ? null : json["addedDate"],
        userLoginId: json["userLoginId"] == null ? null : json["userLoginId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "quantity": quantity == null ? null : quantity,
        "maximumBidPrice": maximumBidPrice == null ? null : maximumBidPrice,
        "minimumBidPrice": minimumBidPrice == null ? null : minimumBidPrice,
        "paymentType": paymentType == null ? null : paymentType,
        "offeredShareId": offeredShareId == null ? null : offeredShareId,
        "offerTimeLimit": offerTimeLimit == null ? null : offerTimeLimit,
        "offerType": offerType == null ? null : offerType,
        "verificationState":
            verificationState == null ? null : verificationState,
        "companyName": companyName == null ? null : companyName,
        "businessLogo": businessLogo == null ? null : businessLogo,
        "lostValuation": lostValuation == null ? null : lostValuation,
        "addedDate": addedDate == null ? null : addedDate,
        "userLoginId": userLoginId == null ? null : userLoginId,
      };
}
