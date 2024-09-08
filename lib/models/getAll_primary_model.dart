// // ignore_for_file: file_names

// import 'dart:convert';

// PrimaryOfferData primaryOfferDataFromJson(String str) =>
//     PrimaryOfferData.fromJson(json.decode(str));

// String primaryOfferDataToJson(PrimaryOfferData data) =>
//     json.encode(data.toJson());

// class PrimaryOfferData {
//   PrimaryOfferData({
//     this.returnCode,
//     this.returnMessage,
//     this.returnData,
//     this.returnStatus,
//   });

//   int? returnCode;
//   String? returnMessage;
//   List<PrimaryOfferDataInfo>? returnData;
//   bool? returnStatus;

//   factory PrimaryOfferData.fromJson(Map<String, dynamic> json) =>
//       PrimaryOfferData(
//         returnCode: json["returnCode"] == null ? null : json["returnCode"],
//         returnMessage:
//             json["returnMessage"] == null ? null : json["returnMessage"],
//         returnData: json["returnData"] == null
//             ? null
//             : List<PrimaryOfferDataInfo>.from(json["returnData"]
//                 .map((x) => PrimaryOfferDataInfo.fromJson(x))),
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

// class PrimaryOfferDataInfo {
//   PrimaryOfferDataInfo({
//     this.companyId,
//     this.companyName,
//     this.offerPrice,
//     this.quantity,
//     this.investmentManager,
//     this.totalTargetAmount,
//     this.minimumInvestment,
//     this.closingDate,
//     this.tags,
//     this.shortDescription,
//     this.raisedAmount,
//     this.daysLeft,
//     this.feePercentage,
//     this.allocation,
//     this.totalInvestors,
//     this.myBidStatus,
//     this.investorDto,
//     this.webView,
//   });

//   int? companyId;
//   String? companyName;
//   double? offerPrice;
//   int? quantity;
//   String? investmentManager;
//   double? totalTargetAmount;
//   double? minimumInvestment;
//   String? closingDate;
//   String? tags;
//   String? shortDescription;
//   int? raisedAmount;
//   String? daysLeft;
//   String? feePercentage;
//   String? allocation;
//   int? totalInvestors;
//   int? myBidStatus;
//   List<InvestorDto>? investorDto;
//   List<WebView>? webView;

//   factory PrimaryOfferDataInfo.fromJson(Map<String, dynamic> json) =>
//       PrimaryOfferDataInfo(
//         companyId: json["companyId"] == null ? null : json["companyId"],
//         companyName: json["companyName"] == null ? null : json["companyName"],
//         offerPrice:
//             json["offerPrice"] == null ? null : json["offerPrice"].toDouble(),
//         quantity: json["quantity"] == null ? null : json["quantity"],
//         investmentManager: json["investmentManager"] == null
//             ? null
//             : json["investmentManager"],
//         totalTargetAmount: json["totalTargetAmount"] == null
//             ? null
//             : json["totalTargetAmount"].toDouble(),
//         minimumInvestment: json["minimumInvestment"] == null
//             ? null
//             : json["minimumInvestment"].toDouble(),
//         closingDate: json["closingDate"] == null ? null : json["closingDate"],
//         tags: json["tags"] == null ? null : json["tags"],
//         shortDescription:
//             json["shortDescription"] == null ? null : json["shortDescription"],
//         raisedAmount:
//             json["raisedAmount"] == null ? null : json["raisedAmount"],
//         daysLeft: json["daysLeft"] == null ? null : json["daysLeft"],
//         feePercentage:
//             json["feePercentage"] == null ? null : json["feePercentage"],
//         allocation: json["allocation"] == null ? null : json["allocation"],
//         totalInvestors:
//             json["totalInvestors"] == null ? null : json["totalInvestors"],
//         myBidStatus: json["myBidStatus"] == null ? null : json["myBidStatus"],
//         investorDto: json["investorDto"] == null
//             ? null
//             : List<InvestorDto>.from(
//                 json["investorDto"].map((x) => InvestorDto.fromJson(x))),
//         webView: json["webView"] == null
//             ? null
//             : List<WebView>.from(
//                 json["webView"].map((x) => WebView.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "companyId": companyId == null ? null : companyId,
//         "companyName": companyName == null ? null : companyName,
//         "offerPrice": offerPrice == null ? null : offerPrice,
//         "quantity": quantity == null ? null : quantity,
//         "investmentManager":
//             investmentManager == null ? null : investmentManager,
//         "totalTargetAmount":
//             totalTargetAmount == null ? null : totalTargetAmount,
//         "minimumInvestment":
//             minimumInvestment == null ? null : minimumInvestment,
//         "closingDate": closingDate == null ? null : closingDate,
//         "tags": tags == null ? null : tags,
//         "shortDescription": shortDescription == null ? null : shortDescription,
//         "raisedAmount": raisedAmount == null ? null : raisedAmount,
//         "daysLeft": daysLeft == null ? null : daysLeft,
//         "feePercentage": feePercentage == null ? null : feePercentage,
//         "allocation": allocation == null ? null : allocation,
//         "totalInvestors": totalInvestors == null ? null : totalInvestors,
//         "myBidStatus": myBidStatus == null ? null : myBidStatus,
//         "investorDto": investorDto == null
//             ? null
//             : List<dynamic>.from(investorDto!.map((x) => x.toJson())),
//         "webView": webView == null
//             ? null
//             : List<dynamic>.from(webView!.map((x) => x.toJson())),
//       };
// }

// class InvestorDto {
//   InvestorDto({
//     this.userLoginId,
//     this.verificationStatus,
//   });

//   int? userLoginId;
//   int? verificationStatus;

//   factory InvestorDto.fromJson(Map<String, dynamic> json) => InvestorDto(
//         userLoginId: json["userLoginId"] == null ? null : json["userLoginId"],
//         verificationStatus: json["verificationStatus"] == null
//             ? null
//             : json["verificationStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userLoginId": userLoginId == null ? null : userLoginId,
//         "verificationStatus":
//             verificationStatus == null ? null : verificationStatus,
//       };
// }

// class WebView {
//   WebView({
//     this.id,
//     this.name,
//     this.value,
//   });

//   int? id;
//   String? name;
//   String? value;

//   factory WebView.fromJson(Map<String, dynamic> json) => WebView(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         value: json["value"] == null ? null : json["value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "name": name == null ? null : name,
//         "value": value == null ? null : value,
//       };
// }
// To parse this JSON data, do
//
//     final primaryOfferData = primaryOfferDataFromJson(jsonString);

import 'dart:convert';

PrimaryOfferData primaryOfferDataFromJson(String str) =>
    PrimaryOfferData.fromJson(json.decode(str));

String primaryOfferDataToJson(PrimaryOfferData data) =>
    json.encode(data.toJson());

class PrimaryOfferData {
  PrimaryOfferData({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<PrimaryOfferDataInfo>? returnData;
  bool? returnStatus;

  factory PrimaryOfferData.fromJson(Map<String, dynamic> json) =>
      PrimaryOfferData(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<PrimaryOfferDataInfo>.from(json["returnData"]
                .map((x) => PrimaryOfferDataInfo.fromJson(x))),
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

class PrimaryOfferDataInfo {
  PrimaryOfferDataInfo({
    this.companyId,
    this.companyName,
    this.offerPrice,
    this.quantity,
    this.investmentManager,
    this.totalTargetAmount,
    this.minimumInvestment,
    this.busraFees,
    this.closingDate,
    this.tags,
    this.shortDescription,
    this.raisedAmount,
    this.daysLeft,
    this.feePercentage,
    this.allocation,
    this.totalInvestors,
    this.myBidStatus,
    this.investorDto,
    this.webView,
  });

  int? companyId;
  String? companyName;
  double? offerPrice;
  int? quantity;
  String? investmentManager;
  double? totalTargetAmount;
  double? minimumInvestment;
  double? busraFees;
  String? closingDate;
  String? tags;
  String? shortDescription;
  int? raisedAmount;
  String? daysLeft;
  String? feePercentage;
  String? allocation;
  int? totalInvestors;
  int? myBidStatus;
  List<InvestorDto>? investorDto;
  List<WebView>? webView;

  factory PrimaryOfferDataInfo.fromJson(Map<String, dynamic> json) =>
      PrimaryOfferDataInfo(
        companyId: json["companyId"] == null ? null : json["companyId"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        offerPrice:
            json["offerPrice"] == null ? null : json["offerPrice"].toDouble(),
        quantity: json["quantity"] == null ? null : json["quantity"],
        investmentManager: json["investmentManager"] == null
            ? null
            : json["investmentManager"],
        totalTargetAmount: json["totalTargetAmount"] == null
            ? null
            : json["totalTargetAmount"].toDouble(),
        minimumInvestment: json["minimumInvestment"] == null
            ? null
            : json["minimumInvestment"].toDouble(),
        busraFees:
            json["busraFees"] == null ? null : json["busraFees"].toDouble(),
        closingDate: json["closingDate"] == null ? null : json["closingDate"],
        tags: json["tags"] == null ? null : json["tags"],
        shortDescription:
            json["shortDescription"] == null ? null : json["shortDescription"],
        raisedAmount:
            json["raisedAmount"] == null ? null : json["raisedAmount"],
        daysLeft: json["daysLeft"] == null ? null : json["daysLeft"],
        feePercentage:
            json["feePercentage"] == null ? null : json["feePercentage"],
        allocation: json["allocation"] == null ? null : json["allocation"],
        totalInvestors:
            json["totalInvestors"] == null ? null : json["totalInvestors"],
        myBidStatus: json["myBidStatus"] == null ? null : json["myBidStatus"],
        investorDto: json["investorDto"] == null
            ? null
            : List<InvestorDto>.from(
                json["investorDto"].map((x) => InvestorDto.fromJson(x))),
        webView: json["webView"] == null
            ? null
            : List<WebView>.from(
                json["webView"].map((x) => WebView.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "companyId": companyId == null ? null : companyId,
        "companyName": companyName == null ? null : companyName,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "quantity": quantity == null ? null : quantity,
        "investmentManager":
            investmentManager == null ? null : investmentManager,
        "totalTargetAmount":
            totalTargetAmount == null ? null : totalTargetAmount,
        "minimumInvestment":
            minimumInvestment == null ? null : minimumInvestment,
        "busraFees": busraFees == null ? null : busraFees,
        "closingDate": closingDate == null ? null : closingDate,
        "tags": tags == null ? null : tags,
        "shortDescription": shortDescription == null ? null : shortDescription,
        "raisedAmount": raisedAmount == null ? null : raisedAmount,
        "daysLeft": daysLeft == null ? null : daysLeft,
        "feePercentage": feePercentage == null ? null : feePercentage,
        "allocation": allocation == null ? null : allocation,
        "totalInvestors": totalInvestors == null ? null : totalInvestors,
        "myBidStatus": myBidStatus == null ? null : myBidStatus,
        "investorDto": investorDto == null
            ? null
            : List<dynamic>.from(investorDto!.map((x) => x.toJson())),
        "webView": webView == null
            ? null
            : List<dynamic>.from(webView!.map((x) => x.toJson())),
      };
}

class InvestorDto {
  InvestorDto({
    this.userLoginId,
    this.verificationStatus,
  });

  int? userLoginId;
  int? verificationStatus;

  factory InvestorDto.fromJson(Map<String, dynamic> json) => InvestorDto(
        userLoginId: json["userLoginId"] == null ? null : json["userLoginId"],
        verificationStatus: json["verificationStatus"] == null
            ? null
            : json["verificationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "userLoginId": userLoginId == null ? null : userLoginId,
        "verificationStatus":
            verificationStatus == null ? null : verificationStatus,
      };
}

class WebView {
  WebView({
    this.id,
    this.name,
    this.value,
  });

  int? id;
  String? name;
  String? value;

  factory WebView.fromJson(Map<String, dynamic> json) => WebView(
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
