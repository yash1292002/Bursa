// import 'dart:convert';

// RegisterdShare registerdShareFromJson(String str) =>
//     RegisterdShare.fromJson(json.decode(str));

// String registerdShareToJson(RegisterdShare data) => json.encode(data.toJson());

// class RegisterdShare {
//   RegisterdShare({
//     this.returnCode,
//     this.returnMessage,
//     this.returnData,
//     this.returnStatus,
//   });

//   int? returnCode;
//   String? returnMessage;
//   List<RegisterShareInfo>? returnData;
//   bool? returnStatus;

//   factory RegisterdShare.fromJson(Map<String, dynamic> json) => RegisterdShare(
//         returnCode: json["returnCode"],
//         returnMessage: json["returnMessage"],
//         returnData: List<RegisterShareInfo>.from(
//             json["returnData"].map((x) => RegisterShareInfo.fromJson(x))),
//         returnStatus: json["returnStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "returnCode": returnCode,
//         "returnMessage": returnMessage,
//         "returnData": List<dynamic>.from(returnData!.map((x) => x.toJson())),
//         "returnStatus": returnStatus,
//       };
// }

// class RegisterShareInfo {
//   RegisterShareInfo({
//     this.id,
//     this.businessLogo,
//     this.shareOwnerShipDocument,
//     this.companyInformationDocument,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phoneNumber,
//     this.companyName,
//     this.grantType,
//     this.equityRound,
//     this.debtRound,
//     this.numberOfShares,
//     this.dateOfGrant,
//     this.sharePrice,
//     this.restriction,
//     this.storageLocation,
//     this.verficationStatus,
//   });

//   int? id;
//   String? businessLogo;
//   String? shareOwnerShipDocument;
//   String? companyInformationDocument;
//   dynamic firstName;
//   dynamic lastName;
//   dynamic email;
//   dynamic phoneNumber;
//   String? companyName;
//   String? grantType;
//   dynamic equityRound;
//   String? debtRound;
//   int? numberOfShares;
//   String? dateOfGrant;
//   int? sharePrice;
//   List<Restriction>? restriction;
//   String? storageLocation;
//   String? verficationStatus;

//   factory RegisterShareInfo.fromJson(Map<String, dynamic> json) =>
//       RegisterShareInfo(
//         id: json["id"],
//         businessLogo: json["businessLogo"],
//         shareOwnerShipDocument: json["shareOwnerShipDocument"],
//         companyInformationDocument: json["companyInformationDocument"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         email: json["email"],
//         phoneNumber: json["phoneNumber"],
//         companyName: json["companyName"],
//         grantType: json["grantType"],
//         equityRound: json["equityRound"],
//         debtRound: json["debtRound"],
//         numberOfShares: json["numberOfShares"],
//         dateOfGrant: json["dateOfGrant"],
//         sharePrice: json["sharePrice"],
//         restriction: List<Restriction>.from(
//             json["restriction"].map((x) => Restriction.fromJson(x))),
//         storageLocation: json["storageLocation"],
//         verficationStatus: json["verficationStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "businessLogo": businessLogo,
//         "shareOwnerShipDocument": shareOwnerShipDocument,
//         "companyInformationDocument": companyInformationDocument,
//         "firstName": firstName,
//         "lastName": lastName,
//         "email": email,
//         "phoneNumber": phoneNumber,
//         "companyName": companyName,
//         "grantType": grantType,
//         "equityRound": equityRound,
//         "debtRound": debtRound,
//         "numberOfShares": numberOfShares,
//         "dateOfGrant": dateOfGrant,
//         "sharePrice": sharePrice,
//         "restriction": List<dynamic>.from(restriction!.map((x) => x.toJson())),
//         "storageLocation": storageLocation,
//         "verficationStatus": verficationStatus,
//       };
// }

// class Restriction {
//   Restriction({
//     this.id,
//     this.name,
//     this.flag,
//   });

//   int? id;
//   String? name;
//   bool? flag;

//   factory Restriction.fromJson(Map<String, dynamic> json) => Restriction(
//         id: json["id"],
//         name: json["name"],
//         flag: json["flag"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "flag": flag,
//       };
// }

// To parse this JSON data, do
//
//     final registerdShare = registerdShareFromJson(jsonString);

// To parse this JSON data, do
//
//     final registerdShare = registerdShareFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

RegisterdShare registerdShareFromJson(String str) =>
    RegisterdShare.fromJson(json.decode(str));

String registerdShareToJson(RegisterdShare data) => json.encode(data.toJson());

class RegisterdShare {
  RegisterdShare({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  List<RegisterShareInfo>? returnData;
  bool? returnStatus;

  factory RegisterdShare.fromJson(Map<String, dynamic> json) => RegisterdShare(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : List<RegisterShareInfo>.from(
                json["returnData"].map((x) => RegisterShareInfo.fromJson(x))),
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

class RegisterShareInfo {
  RegisterShareInfo({
    this.id,
    this.businessLogo,
    this.shareOwnerShipDocument,
    this.companyInformationDocument,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.companyName,
    this.grantType,
    this.equityRound,
    this.debtRound,
    this.numberOfShares,
    this.dateOfGrant,
    this.sharePrice,
    this.lastValuation,
    this.grantValuation,
    this.restriction,
    this.storageLocation,
    this.verficationStatus,
  });

  int? id;
  String? businessLogo;
  String? shareOwnerShipDocument;
  String? companyInformationDocument;
  String? firstName;
  dynamic lastName;
  String? email;
  String? phoneNumber;
  String? companyName;
  String? grantType;
  String? equityRound;
  String? debtRound;
  int? numberOfShares;
  String? dateOfGrant;
  int? sharePrice;
  String? lastValuation;
  String? grantValuation;
  List<Restriction>? restriction;
  String? storageLocation;
  String? verficationStatus;

  factory RegisterShareInfo.fromJson(Map<String, dynamic> json) =>
      RegisterShareInfo(
        id: json["id"] == null ? null : json["id"],
        businessLogo:
            json["businessLogo"] == null ? null : json["businessLogo"],
        shareOwnerShipDocument: json["shareOwnerShipDocument"] == null
            ? null
            : json["shareOwnerShipDocument"],
        companyInformationDocument: json["companyInformationDocument"] == null
            ? null
            : json["companyInformationDocument"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        grantType: json["grantType"] == null ? null : json["grantType"],
        equityRound: json["equityRound"] == null ? null : json["equityRound"],
        debtRound: json["debtRound"] == null ? null : json["debtRound"],
        numberOfShares:
            json["numberOfShares"] == null ? null : json["numberOfShares"],
        dateOfGrant: json["dateOfGrant"] == null ? null : json["dateOfGrant"],
        sharePrice: json["sharePrice"] == null ? null : json["sharePrice"],
        lastValuation:
            json["lastValuation"] == null ? null : json["lastValuation"],
        grantValuation:
            json["grantValuation"] == null ? null : json["grantValuation"],
        restriction: json["restriction"] == null
            ? null
            : List<Restriction>.from(
                json["restriction"].map((x) => Restriction.fromJson(x))),
        storageLocation:
            json["storageLocation"] == null ? null : json["storageLocation"],
        verficationStatus: json["verficationStatus"] == null
            ? null
            : json["verficationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "businessLogo": businessLogo == null ? null : businessLogo,
        "shareOwnerShipDocument":
            shareOwnerShipDocument == null ? null : shareOwnerShipDocument,
        "companyInformationDocument": companyInformationDocument == null
            ? null
            : companyInformationDocument,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "companyName": companyName == null ? null : companyName,
        "grantType": grantType == null ? null : grantType,
        "equityRound": equityRound == null ? null : equityRound,
        "debtRound": debtRound == null ? null : debtRound,
        "numberOfShares": numberOfShares == null ? null : numberOfShares,
        "dateOfGrant": dateOfGrant == null ? null : dateOfGrant,
        "sharePrice": sharePrice == null ? null : sharePrice,
        "lastValuation": lastValuation == null ? null : lastValuation,
        "grantValuation": grantValuation == null ? null : grantValuation,
        "restriction": restriction == null
            ? null
            : List<dynamic>.from(restriction!.map((x) => x.toJson())),
        "storageLocation": storageLocation == null ? null : storageLocation,
        "verficationStatus":
            verficationStatus == null ? null : verficationStatus,
      };
}

class Restriction {
  Restriction({
    this.id,
    this.name,
    this.flag,
  });

  int? id;
  String? name;
  bool? flag;

  factory Restriction.fromJson(Map<String, dynamic> json) => Restriction(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        flag: json["flag"] == null ? null : json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "flag": flag == null ? null : flag,
      };
}
