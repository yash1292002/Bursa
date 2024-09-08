// // To parse this JSON data, do
// //
// //     final userInfo = userInfoFromJson(jsonString);

// import 'dart:convert';

// UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

// String userInfoToJson(UserInfo data) => json.encode(data.toJson());

// class UserInfo {
//   UserInfo({
//     this.returnCode,
//     this.returnMessage,
//     this.returnData,
//     this.returnStatus,
//   });

//   int? returnCode;
//   String? returnMessage;
//   UserDetail? returnData;
//   bool? returnStatus;

//   factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
//         returnCode: json["returnCode"],
//         returnMessage: json["returnMessage"],
//         returnData: UserDetail.fromJson(json["returnData"]),
//         returnStatus: json["returnStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "returnCode": returnCode,
//         "returnMessage": returnMessage,
//         "returnData": returnData!.toJson(),
//         "returnStatus": returnStatus,
//       };
// }

// class UserDetail {
//   UserDetail({
//     this.personId,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phoneNumber,
//     this.dateOfBirth,
//     this.isUsCitizen,
//     this.isPublicSectorEmployee,
//     this.isIndividual,
//     this.haveCriminalRecord,
//     this.haveConvicted,
//     this.city,
//     this.addressLine,
//     this.emiratesId,
//     this.vaultNumber,
//     this.ibanNumber,
//     this.country,
//     this.nationality,
//     this.employementId,
//     this.employerName,
//     this.annualIncome,
//     this.dateOfEmployement,
//     this.havePriorExpirence,
//     this.haveTraining,
//     this.haveExperience,
//     this.verificationState,
//     this.emiratesIdPictureFront,
//     this.emiratesIdPictureBack,
//     this.role,
//     this.investorType,
//   });

//   int? personId;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? phoneNumber;
//   DateTime? dateOfBirth;
//   bool? isUsCitizen;
//   bool? isPublicSectorEmployee;
//   bool? isIndividual;
//   bool? haveCriminalRecord;
//   bool? haveConvicted;
//   String? city;
//   String? addressLine;
//   String? emiratesId;
//   String? vaultNumber;
//   String? ibanNumber;
//   String? country;
//   String? nationality;
//   String? employementId;
//   String? employerName;
//   int? annualIncome;
//   DateTime? dateOfEmployement;
//   bool? havePriorExpirence;
//   bool? haveTraining;
//   bool? haveExperience;
//   String? verificationState;
//   String? emiratesIdPictureFront;
//   String? emiratesIdPictureBack;
//   String? role;
//   String? investorType;

//   factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
//         personId: json["personId"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         email: json["email"],
//         phoneNumber: json["phoneNumber"],
//         dateOfBirth: DateTime.parse(json["dateOfBirth"]),
//         isUsCitizen: json["isUSCitizen"],
//         isPublicSectorEmployee: json["isPublicSectorEmployee"],
//         isIndividual: json["isIndividual"],
//         haveCriminalRecord: json["haveCriminalRecord"],
//         haveConvicted: json["haveConvicted"],
//         city: json["city"],
//         addressLine: json["addressLine"],
//         emiratesId: json["emiratesID"],
//         vaultNumber: json["vaultNumber"],
//         ibanNumber: json["ibanNumber"],
//         country: json["country"],
//         nationality: json["nationality"],
//         employementId: json["employementId"],
//         employerName: json["employerName"],
//         annualIncome: json["annualIncome"],
//         dateOfEmployement: DateTime.parse(json["dateOfEmployement"]),
//         havePriorExpirence: json["havePriorExpirence"],
//         haveTraining: json["haveTraining"],
//         haveExperience: json["haveExperience"],
//         verificationState: json["verificationState"],
//         emiratesIdPictureFront: json["emiratesIdPictureFront"],
//         emiratesIdPictureBack: json["emiratesIdPictureBack"],
//         role: json["role"],
//         investorType: json["investorType"],
//       );

//   Map<String, dynamic> toJson() => {
//         "personId": personId,
//         "firstName": firstName,
//         "lastName": lastName,
//         "email": email,
//         "phoneNumber": phoneNumber,
//         "dateOfBirth":
//             "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
//         "isUSCitizen": isUsCitizen,
//         "isPublicSectorEmployee": isPublicSectorEmployee,
//         "isIndividual": isIndividual,
//         "haveCriminalRecord": haveCriminalRecord,
//         "haveConvicted": haveConvicted,
//         "city": city,
//         "addressLine": addressLine,
//         "emiratesID": emiratesId,
//         "vaultNumber": vaultNumber,
//         "ibanNumber": ibanNumber,
//         "country": country,
//         "nationality": nationality,
//         "employementId": employementId,
//         "employerName": employerName,
//         "annualIncome": annualIncome,
//         "dateOfEmployement":
//             "${dateOfEmployement!.year.toString().padLeft(4, '0')}-${dateOfEmployement!.month.toString().padLeft(2, '0')}-${dateOfEmployement!.day.toString().padLeft(2, '0')}",
//         "havePriorExpirence": havePriorExpirence,
//         "haveTraining": haveTraining,
//         "haveExperience": haveExperience,
//         "verificationState": verificationState,
//         "emiratesIdPictureFront": emiratesIdPictureFront,
//         "emiratesIdPictureBack": emiratesIdPictureBack,
//         "role": role,
//         "investorType": investorType,
//       };
// }

// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.returnCode,
    this.returnMessage,
    this.returnData,
    this.returnStatus,
  });

  int? returnCode;
  String? returnMessage;
  UserDetail? returnData;
  bool? returnStatus;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        returnCode: json["returnCode"] == null ? null : json["returnCode"],
        returnMessage:
            json["returnMessage"] == null ? null : json["returnMessage"],
        returnData: json["returnData"] == null
            ? null
            : UserDetail.fromJson(json["returnData"]),
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

class UserDetail {
  UserDetail({
    this.personId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.isUsCitizen,
    this.isPublicSectorEmployee,
    this.isIndividual,
    this.haveCriminalRecord,
    this.haveConvicted,
    this.city,
    this.addressLine,
    this.emiratesId,
    this.vaultNumber,
    this.ibanNumber,
    this.country,
    this.nationality,
    this.employementId,
    this.employerName,
    this.annualIncome,
    this.dateOfEmployement,
    this.havePriorExpirence,
    this.haveTraining,
    this.haveExperience,
    this.verificationState,
    this.emiratesIdPictureFront,
    this.emiratesIdPictureBack,
    this.role,
    this.investorType,
    this.investorRiskType,
    this.addedDate,
    this.userLoginId,
  });

  int? personId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  DateTime? dateOfBirth;
  bool? isUsCitizen;
  bool? isPublicSectorEmployee;
  bool? isIndividual;
  bool? haveCriminalRecord;
  bool? haveConvicted;
  String? city;
  String? addressLine;
  String? emiratesId;
  String? vaultNumber;
  String? ibanNumber;
  String? country;
  String? nationality;
  String? employementId;
  String? employerName;
  int? annualIncome;
  DateTime? dateOfEmployement;
  bool? havePriorExpirence;
  bool? haveTraining;
  bool? haveExperience;
  String? verificationState;
  String? emiratesIdPictureFront;
  String? emiratesIdPictureBack;
  String? role;
  String? investorType;
  String? investorRiskType;
  String? addedDate;
  int? userLoginId;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        personId: json["personId"] == null ? null : json["personId"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        isUsCitizen: json["isUSCitizen"] == null ? null : json["isUSCitizen"],
        isPublicSectorEmployee: json["isPublicSectorEmployee"] == null
            ? null
            : json["isPublicSectorEmployee"],
        isIndividual:
            json["isIndividual"] == null ? null : json["isIndividual"],
        haveCriminalRecord: json["haveCriminalRecord"] == null
            ? null
            : json["haveCriminalRecord"],
        haveConvicted:
            json["haveConvicted"] == null ? null : json["haveConvicted"],
        city: json["city"] == null ? null : json["city"],
        addressLine: json["addressLine"] == null ? null : json["addressLine"],
        emiratesId: json["emiratesID"] == null ? null : json["emiratesID"],
        vaultNumber: json["vaultNumber"] == null ? null : json["vaultNumber"],
        ibanNumber: json["ibanNumber"] == null ? null : json["ibanNumber"],
        country: json["country"] == null ? null : json["country"],
        nationality: json["nationality"] == null ? null : json["nationality"],
        employementId:
            json["employementId"] == null ? null : json["employementId"],
        employerName:
            json["employerName"] == null ? null : json["employerName"],
        annualIncome:
            json["annualIncome"] == null ? null : json["annualIncome"],
        dateOfEmployement: json["dateOfEmployement"] == null
            ? null
            : DateTime.parse(json["dateOfEmployement"]),
        havePriorExpirence: json["havePriorExpirence"] == null
            ? null
            : json["havePriorExpirence"],
        haveTraining:
            json["haveTraining"] == null ? null : json["haveTraining"],
        haveExperience:
            json["haveExperience"] == null ? null : json["haveExperience"],
        verificationState: json["verificationState"] == null
            ? null
            : json["verificationState"],
        emiratesIdPictureFront: json["emiratesIdPictureFront"] == null
            ? null
            : json["emiratesIdPictureFront"],
        emiratesIdPictureBack: json["emiratesIdPictureBack"] == null
            ? null
            : json["emiratesIdPictureBack"],
        role: json["role"] == null ? null : json["role"],
        investorType:
            json["investorType"] == null ? null : json["investorType"],
        investorRiskType:
            json["investorRiskType"] == null ? null : json["investorRiskType"],
        addedDate: json["addedDate"] == null ? null : json["addedDate"],
        userLoginId: json["userLoginId"] == null ? null : json["userLoginId"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId == null ? null : personId,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "dateOfBirth": dateOfBirth == null
            ? null
            : "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "isUSCitizen": isUsCitizen == null ? null : isUsCitizen,
        "isPublicSectorEmployee":
            isPublicSectorEmployee == null ? null : isPublicSectorEmployee,
        "isIndividual": isIndividual == null ? null : isIndividual,
        "haveCriminalRecord":
            haveCriminalRecord == null ? null : haveCriminalRecord,
        "haveConvicted": haveConvicted == null ? null : haveConvicted,
        "city": city == null ? null : city,
        "addressLine": addressLine == null ? null : addressLine,
        "emiratesID": emiratesId == null ? null : emiratesId,
        "vaultNumber": vaultNumber == null ? null : vaultNumber,
        "ibanNumber": ibanNumber == null ? null : ibanNumber,
        "country": country == null ? null : country,
        "nationality": nationality == null ? null : nationality,
        "employementId": employementId == null ? null : employementId,
        "employerName": employerName == null ? null : employerName,
        "annualIncome": annualIncome == null ? null : annualIncome,
        "dateOfEmployement": dateOfEmployement == null
            ? null
            : "${dateOfEmployement!.year.toString().padLeft(4, '0')}-${dateOfEmployement!.month.toString().padLeft(2, '0')}-${dateOfEmployement!.day.toString().padLeft(2, '0')}",
        "havePriorExpirence":
            havePriorExpirence == null ? null : havePriorExpirence,
        "haveTraining": haveTraining == null ? null : haveTraining,
        "haveExperience": haveExperience == null ? null : haveExperience,
        "verificationState":
            verificationState == null ? null : verificationState,
        "emiratesIdPictureFront":
            emiratesIdPictureFront == null ? null : emiratesIdPictureFront,
        "emiratesIdPictureBack":
            emiratesIdPictureBack == null ? null : emiratesIdPictureBack,
        "role": role == null ? null : role,
        "investorType": investorType == null ? null : investorType,
        "investorRiskType": investorRiskType == null ? null : investorRiskType,
        "addedDate": addedDate == null ? null : addedDate,
        "userLoginId": userLoginId == null ? null : userLoginId,
      };
}
