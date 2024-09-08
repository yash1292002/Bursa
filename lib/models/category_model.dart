// // ignore_for_file: prefer_if_null_operators

// import 'dart:convert';

// CategoryInfo categoryInfoFromJson(String str) =>
//     CategoryInfo.fromJson(json.decode(str));

// String categoryInfoToJson(CategoryInfo data) => json.encode(data.toJson());

// class CategoryInfo {
//   CategoryInfo({
//     this.returnCode,
//     this.returnMessage,
//     this.returnData,
//     this.returnStatus,
//   });

//   int? returnCode;
//   String? returnMessage;
//   List<CategoryInfoData>? returnData;
//   bool? returnStatus;

//   factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
//         returnCode: json["returnCode"] == null ? null : json["returnCode"],
//         returnMessage:
//             json["returnMessage"] == null ? null : json["returnMessage"],
//         returnData: json["returnData"] == null
//             ? null
//             : List<CategoryInfoData>.from(
//                 json["returnData"].map((x) => CategoryInfoData.fromJson(x))),
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

// class CategoryInfoData {
//   CategoryInfoData({
//     this.id,
//     this.name,
//     this.content,
//     this.totalShares,
//     this.offerPrice,
//     this.offerShareId,
//   });

//   int? id;
//   String? name;
//   String? content;
//   int? totalShares;
//   int? offerPrice;
//   int? offerShareId;

//   factory CategoryInfoData.fromJson(Map<String, dynamic> json) =>
//       CategoryInfoData(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         content: json["content"] == null ? null : json["content"],
//         totalShares: json["totalShares"] == null ? null : json["totalShares"],
//         offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
//         offerShareId:
//             json["offerShareId"] == null ? null : json["offerShareId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "name": name == null ? null : name,
//         "content": content == null ? null : content,
//         "totalShares": totalShares == null ? null : totalShares,
//         "offerPrice": offerPrice == null ? null : offerPrice,
//         "offerShareId": offerShareId == null ? null : offerShareId,
//       };
// }
// To parse this JSON data, do
//
//     final categoryInfo = categoryInfoFromJson(jsonString);

import 'dart:convert';

CategoryInfo categoryInfoFromJson(String str) =>
    CategoryInfo.fromJson(json.decode(str));

String categoryInfoToJson(CategoryInfo data) => json.encode(data.toJson());

class CategoryInfo {
  CategoryInfo({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<CategoryInfoData>? returnData;
  bool? returnStatus;

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<CategoryInfoData>.from(
                json["returnData"].map((x) => CategoryInfoData.fromJson(x))),
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

class CategoryInfoData {
  CategoryInfoData({
    this.id,
    this.title,
    this.content,
  });

  int? id;
  String? title;
  String? content;

  factory CategoryInfoData.fromJson(Map<String, dynamic> json) =>
      CategoryInfoData(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
      };
}
