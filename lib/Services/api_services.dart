import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/controllers/issue_digital_controller.dart';
import 'package:bursa_flutter/controllers/offer_share_controller.dart';
import 'package:bursa_flutter/controllers/primary_offer_controller.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:bursa_flutter/models/getAll_primary_model.dart';
import 'package:bursa_flutter/models/offer_share_model.dart';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/register_share_Controller.dart';
import '../models/verify_response_model.dart';
import 'shared_pref_services.dart';

class ApiServices {
  String baseUrl = "https://origin-stage.getbursa.com/";
  // String baseUrl = "https://backoffice-stage.getbursa.com/";

  // Future<http.Response> registerUser(Map<String, dynamic> data) async {
  //   Uri url = Uri.parse(baseUrl + "/api/Registration");
  //   return await http.post(url,
  //       body: data,
  //       headers: {"Content-Type": "multipart/form-data", "accept": "*/*"});
  // }

  ///=================================Register New User ======================================
  Future<http.StreamedResponse> registerUser(
      _fullNameController,
      // _lastNameController,
      _emailController,
      _birthOfDateController,
      _phoneNumberController,
      _kycAnswers,
      _cityNameController,
      _addressNameController,
      _selectedCountry,
      _selectedNationality,
      _selectedEmployement,
      _incomeTextController,
      _dateOfEmploymentController,
      _educationAnswers,
      _otpControllers,
      _employeeNameController,
      _emirateId,
      _frontImage,
      _backImage) async {
    String passCode = "";
    for (var item in _otpControllers!) {
      passCode += item.text.trim();
    }
    AuthController _authController =
        Provider.of<AuthController>(Get.context!, listen: false);

    var dateOfBirth = _authController.convertDateFormat(
        _birthOfDateController.text.toString(), "dd/MM/yyyy", "yyyy-MM-dd");
    log("Date OF Birth--->" + dateOfBirth.toString());
    var dateOfEmployement = _authController.convertDateFormat(
        _dateOfEmploymentController.text.toString(),
        "dd/MM/yyyy",
        "yyyy-MM-dd");
    log("Date OF Birth--->" + dateOfEmployement.toString());

    String str = _incomeTextController.text.trim();
    String incomeTextController = str.replaceAll(RegExp('[^0-9]'), '');
    Uri url = Uri.parse(baseUrl + "api/Registration");
    var request = http.MultipartRequest("POST", url);
    request.fields['Person.FirstName'] = _fullNameController.text.trim();
    request.fields['Person.LastName'] = "-";
    request.fields['Person.Email'] = _emailController.text.trim();
    request.fields['Person.DateOfBirth'] = dateOfBirth;
    request.fields['Person.PhoneNumber'] = _phoneNumberController.text.trim();
    request.fields['PersonalInfo.IsUSCitizen'] =
        (_kycAnswers[0] == "Yes" ? true : false).toString();
    request.fields['PersonalInfo.IsPublicSectorEmployee'] =
        (_kycAnswers[1] == "Yes" ? true : false).toString();
    request.fields['PersonalInfo.IsIndividual'] =
        (_kycAnswers[2] == "Yes" ? true : false).toString();
    request.fields['PersonalInfo.HaveCriminalRecord'] =
        (_kycAnswers[3] == "Yes" ? true : false).toString();
    request.fields['PersonalInfo.HaveConvicted'] =
        (_kycAnswers[4] == "Yes" ? true : false).toString();
    // request.fields['PersonalInfo.EmiratesID'] = "784-1968-6570307-8";
    request.fields['PersonalInfo.EmiratesID'] = _emirateId.toString();
    request.fields['Address.City'] = _cityNameController.text.trim();
    request.fields['Address.AddressLine'] = _addressNameController.text.trim();
    request.fields['Address.CountryId'] = _selectedCountry!.toString();
    request.fields['Address.NationalityId'] = _selectedNationality!.toString();
    request.fields['Employement.EmployementTypeId'] =
        _selectedEmployement.toString();
    request.fields['Employement.AnnualIncome'] =
        int.parse(incomeTextController).toString();
    request.fields['Employement.DateOfEmployement'] =
        // _dateOfEmploymentController.text.trim();
        dateOfEmployement;
    request.fields['Experience.HavePriorExpirence'] =
        (_educationAnswers[0] == "Yes" ? true : false).toString();
    request.fields['Experience.HaveTraining'] =
        (_educationAnswers[1] == "Yes" ? true : false).toString();
    request.fields["Experience.HaveExperience"] =
        (_educationAnswers[2] == "Yes" ? true : false).toString();

    request.fields["UserLogin.Passcode"] = passCode;
    // request.fields["Attachments"]=[_frontImage,_backImage].toString();
    //TODO need to change PersonalInfo.VerificationState
    request.fields['PersonalInfo.VerificationState'] = "1";
    request.fields['Employement.EmployerName'] =
        _employeeNameController.text.trim();

    var multiport1 =
        await http.MultipartFile.fromPath("Attachments", _frontImage!.path);

    var multiport2 =
        await http.MultipartFile.fromPath("Attachments", _backImage!.path);
    request.files.addAll([multiport1, multiport2]);

    log("Request body ----- " + request.fields.toString());
    var response = await request.send();

    return response;
  }

  Future<bool> verifyEmailOrPhone(String emailOrPhone) async {
    String url = baseUrl + "api/Auth/CheckEmailOrPhone";
    d.Dio dio = d.Dio();
    d.Response response;
    try {
      //404
      response = await dio.post(url, data: {"emailOrPhone": emailOrPhone});

      if (response.data != null) {
        VerifyResponseModel verifyResponseModel =
            VerifyResponseModel.fromJson(response.data);
        log("verifyResponseModel");
        print(verifyResponseModel.toJson());
        if (verifyResponseModel.returnData == true) {
          return true;
        }
      }
      log("verifyResponseModel");
      return false;
    } on d.DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        log("e.response != null");
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        log("e.response == null");

        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      return false;
    }
  }

  Future<bool> verifyEmiratesId(String emiratesId) async {
    String url = baseUrl + "api/Auth/CheckEmiratesId";
    d.Dio dio = d.Dio();
    d.Response response;
    try {
      //404
      response = await dio.post(url, data: {"emiratesId": emiratesId});

      if (response.data != null) {
        VerifyResponseModel verifyResponseModel =
            VerifyResponseModel.fromJson(response.data);
        if (verifyResponseModel.returnData == true) {
          return true;
        }
      }

      return false;
    } on d.DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      return false;
    }
  }

  Future<http.Response> loginUser(Map<String, dynamic> data) async {
    Uri url = Uri.parse(baseUrl + "api/Auth");
    return await http.post(
      url,
      body: json.encode(data),
      headers: {
        'Content-type': 'application/json',
        'Accept': '*/*',
      },
    );
  }

// ================================== forget Passcode ===============

  Future<http.Response> forgetPassCode(Map<String, dynamic> data) async {
    Uri url = Uri.parse(baseUrl + "api/ForgotPasscode");
    return await http.post(url,
        body: json.encode(data),
        headers: {"accept": "*/*", "Content-Type": "application/json"});
  }

//=========================
// ==============================

  // get countery api
  Future<http.Response> getCountryList() async {
    Uri url = Uri.parse(baseUrl + "api/Countries");
    return await http.get(url);
  }

//=============================== get nationality api===========================
  Future<http.Response> getNationalitiesList() async {
    Uri url = Uri.parse(baseUrl + "api/Nationalities");
    return await http.get(url);
  }

//============================== get Employement Api=====================
  Future<http.Response> getEmployementDataList() async {
    Uri url = Uri.parse(baseUrl + "api/EmployementTypes");
    return await http.get(url);
  }

// ==============================get Company List=================================
  Future<http.Response> getCompanyList() async {
    Uri url = Uri.parse(baseUrl + "api/Companies");
    return await http.get(url);
  }

//====================== Sent Otp =======================

  Future<http.Response> sendOtp(Map<String, dynamic> data) async {
    Uri url = Uri.parse(baseUrl + "api/SendOTP/SendOTP");
    return await http.post(url,
        body: json.encode(data),
        headers: {"Content-Type": "application/json", "accept": "*/*"});
  }

// =========================== verify Otp ====================
  Future<http.Response> verifyOtp(Map<String, dynamic> data) async {
    Uri url = Uri.parse(baseUrl + "api/SendOTP/VerifyOTP");
    return await http.post(url,
        body: json.encode(data),
        headers: {"Content-Type": "application/json", "accept": "*/*"});
  }

  //========================= get grant type==========================
  Future<http.Response> getGrantType() async {
    String? token = SharedPrefService().getToken();
    log("Token ---- " + token.toString());
    Uri url = Uri.parse(baseUrl + "api/GrantTypes");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

//========================= get the euity rounds=============================
  Future<http.Response> getEquityRounds() async {
    String? token = SharedPrefService().getToken();
    log("Token" + token.toString());
    Uri url = Uri.parse(baseUrl + "api/EquityRounds");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

//===================  get DebtRound ===============================
  Future<http.Response> getDebtRound() async {
    String? token = SharedPrefService().getToken();
    log("Token" + token.toString());
    Uri url = Uri.parse(baseUrl + "api/DebtRounds");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

// =========================== get Registered Shares List ==============================
  Future<http.Response> getRegisterdSharesList() async {
    String? token = SharedPrefService().getToken();
    log("token--------" + token.toString());
    Uri url = Uri.parse(baseUrl + "api/GetRegisteredShares");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

// ================================== Register Share ==================================
  Future<d.Response?> registerShare(
      // _selectedCompanies,
      _comapnyNameController,
      _selectedGrantTypes,
      _selectedEquityRounds,
      _selectedDebtRound,
      _numberofShareController,
      _dateOfEmploymentController,
      _rupeesController,
      _isRestrication,
      _isRestrication1,
      _lastValuation,
      _grantValuation,
      _firstNameController,
      // _lastNameController,
      _emailController,
      _phoneNumberController,
      File? _pdffile,
      File? _pdf1file,
      File? _photofile) async {
    String? token = SharedPrefService().getToken();
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(Get.context!, listen: false);
    _registerShareController.initProgress();

    try {
      // AppLoading.progressDialog(context: context);
      d.Dio dio = d.Dio();
      d.Response response;

      String str = _numberofShareController.text.trim();
      String numberofShare = str.replaceAll(RegExp('[^0-9]'), '');
      String str1 = _rupeesController.text.trim();
      String rupees = str1.replaceAll(RegExp('[^0-9]'), '');
      log("Result----->" + rupees);

      log("datatatatt--->" + _dateOfEmploymentController.text);
      log("Dateee bdhsbdhs" + DateTime.now().toString());

      //String date = _dateOfEmploymentController.text.trim();
      // var date1 = DateFormat("yyyy-MM-dd").format(DateTime.parse(date));
      // DateTime tempDatew = DateFormat("yyyy/MM/dd")
      //     .parse(_dateOfEmploymentController.text.trim());

      // log("Result----->" + tempDatew.toString());

      // var dateFormate = DateFormat("yyyy-MM-dd")
      //     .format(DateTime.parse(_dateOfEmploymentController.text.trim()));

      var date1 = _registerShareController.convertDateFormat(
          _dateOfEmploymentController.text.toString(),
          "dd/MM/yyyy",
          "yyyy-MM-dd");

      log("date1date1date1date1--->" + date1.toString());

      d.FormData formData = d.FormData.fromMap(
        <String, dynamic>{
          "BusinessLogo": _pdffile?.path == null
              ? ""
              : await d.MultipartFile.fromFile(
                  _pdffile?.path ?? "",
                ),
          "ShareOwnershipDocument": _pdf1file?.path == null
              ? ""
              : await d.MultipartFile.fromFile(
                  _pdf1file?.path ?? "",
                ),
          "CompanyInformationDocument": _photofile?.path == null
              ? ""
              : await d.MultipartFile.fromFile(
                  _photofile?.path ?? "",
                ),
          'ShareInformation.CompanyName': _comapnyNameController.text.trim(),
          'ShareInformation.GrantTypeId': _selectedGrantTypes.toString(),
          'ShareInformation.EquityRoundId': _selectedEquityRounds.toString(),
          'ShareInformation.DebtRoundId': _selectedDebtRound.toString(),
          'ShareInformation.NumberOfShares': int.parse(numberofShare),
          'ShareInformation.DateOfGrant': date1,
          // _dateOfEmploymentController.text.trim(),
          'ShareInformation.SharePrice': rupees,
          'ShareInformation.Restriction1': _isRestrication.toString(),
          'ShareInformation.Restriction2': _isRestrication1.toString(),
          'ShareInformation.StorageLocationId': "0",
          'ShareInformation.LastValuation': _lastValuation.text.trim(),
          'ShareInformation.GrantValuation': _grantValuation.text.trim(),
          "ContactPerson.FirstName": _firstNameController.text.trim(),
          //"ContactPerson.LastName":_lastNameController.text.trim(),
          "ContactPerson.Email": _emailController.text.trim(),
          "ContactPerson.PhoneNumber": _phoneNumberController.text.trim()
        },
      );

      response = await dio.post(
        baseUrl + "api/RegisterShare",
        data: formData,
        options: d.Options(headers: {
          "accept": "*/*",
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $token"
        }),
        onSendProgress: (int sent, int total) {
          log('progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');

          double p = double.parse((sent / total * 100).toStringAsFixed(0));

          if (p > 2 && p < 100) {
            p = p - 1;
          }
          _registerShareController.updateProgress(p);
        },
      );

      if (response.statusCode == 200) {
        log("Image Uploaded ====");

        return response;
      }
    } on d.DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

// ============================== get Registered Share =================================
  Future<http.Response> getRegisteredShares() async {
    String? token = SharedPrefService().getToken();
    log("Token" + token.toString());
    Uri url = Uri.parse(baseUrl + "api/GetRegisteredShares");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

// ================================= Refesh Token =====================================
  Future<http.Response> refreshToken() async {
    String? token = SharedPrefService().getToken();
    String? refreshTokenData = SharedPrefService().getRefreshToken();

    log("Token   " + token.toString());
    log("refresh token  " + refreshTokenData.toString());

    Map<String, dynamic> data = {
      "accessToken": token,
      "refreshToken": refreshTokenData
    };
    Uri url = Uri.parse(baseUrl + "api/RefreshToken");
    return await http.post(url,
        headers: {"accept": "*/*", "Content-Type": "application/json"},
        body: json.encode(data));
  }

  // issue digital certificate
  Future<d.Response?> issueDigitalShare(
      _selectedShareValue,
      _firstNameController,
      // _lastNameController,
      // _middleNameController,
      _dateOfEmploymentController,
      _companyNameController,
      _certified,
      _shareNumberController,
      signature) async {
    String? token = SharedPrefService().getToken();
    IssueDigitalCertiController _controller =
        Provider.of<IssueDigitalCertiController>(Get.context!, listen: false);
    _controller.initProgress();

    try {
      d.Dio dio = d.Dio();
      d.Response response;

      d.FormData formData = d.FormData.fromMap(<String, dynamic>{
        "ShareId": _selectedShareValue.toString(),
        "FirstName": _firstNameController.text.trim(),
        "LastName": "",
        "MiddleName": "",
        "DateOfBirth": _dateOfEmploymentController.text.trim(),
        "CompanyName": _companyNameController.text.trim(),
        "IsCertified": (_certified == "Certified" ? true : false).toString(),
        "NumberOfShares": _shareNumberController.text.trim(),
        "Signature": await d.MultipartFile.fromFile(
          signature.path ?? "",
        ),
      });
      response = await dio.post(
        baseUrl + "api/IssueDigitalShare",
        data: formData,
        options: d.Options(
          headers: {
            "accept": "*/*",
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token"
          },
        ),
        onSendProgress: (int sent, int total) {
          log('progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');

          double p = double.parse((sent / total * 100).toStringAsFixed(0));

          if (p > 2 && p < 100) {
            p = p - 1;
          }
          _controller.updateProgress(p);
        },
      );
      if (response.statusCode == 200) {
        // print("Image Uploaded ====");

        return response;
      }
    } on d.DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }

    // log("Share id ---- " + _selectedShareValue.toString());
    // Uri url = Uri.parse(baseUrl + "api/IssueDigitalShare");
    // var request = http.MultipartRequest("POST", url);
    // request.fields['ShareId'] = _selectedShareValue.toString();
    // request.fields['FirstName'] = _firstNameController.text.trim();
    // request.fields['LastName'] = "";
    // request.fields['MiddleName'] = "";
    // request.fields['DateOfBirth'] = _dateOfEmploymentController.text.trim();
    // request.fields['CompanyName'] = _companyNameController.text.trim();
    // // request.fields['CompanyId'] = _selectedShareValue.toString();
    // request.fields['IsCertified'] =
    //     (_certified == "Certified" ? true : false).toString();
    // request.fields['NumberOfShares'] = _shareNumberController.text.trim();
    // // final tempDir = await getTemporaryDirectory();
    // // io.File file =
    // //     await io.File('${tempDir.path}/${DateTime.now()}.png').create();
    // var multipart =
    //     await http.MultipartFile.fromPath("Signature", signature.path);
    // request.files.add(multipart);
    // request.headers.addAll({
    //   "accept": "*/*",
    //   "Content-Type": "multipart/form-data",
    //   "Authorization": "Bearer $token"
    // });
    // var response = await request.send();
    // return response;
  }

  /// get all issued shared certificates
  Future<http.Response> getAllIssuesShare() async {
    String? token = SharedPrefService().getToken();
    log("token----------" + token.toString());
    Uri url = Uri.parse(baseUrl + "api/GetAllIssuedShares");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

// ============================ get user Info ===================================
  Future<http.Response> getUserInfo() async {
    String? token = SharedPrefService().getToken();
    log("token----------" + token.toString());
    Uri url = Uri.parse(baseUrl + "api/GetProfileInformation");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

// ======================== get Offer Time Limits ==============================
  Future<http.Response> getOfferTimeLimits() async {
    String? token = SharedPrefService().getToken();
    Uri url = Uri.parse("${baseUrl}api/GetAllOfferTimeLimits");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

//============================ get all Payment offerd share ======================
  Future<http.Response> getAllOfferedPayment() async {
    String? token = SharedPrefService().getToken();
    Uri url = Uri.parse(baseUrl + "api/GetAllOfferedPayment");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

// ================================ Get Comapny Shares ==============================
  Future<http.Response> getCompanyShares() async {
    String? token = SharedPrefService().getToken();
    Uri url = Uri.parse(baseUrl + "api/GetCompaniesWithShareOffered");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

//================================= Get Bursa Fees =====================================
  Future<http.Response> getBursaFees() async {
    String? token = SharedPrefService().getToken();
    Uri url = Uri.parse("${baseUrl}api/GetBusraFee");
    return await http.post(url,
        headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

//================================= add Offer Share ====================================
  Future<d.Response?> addOfferShare(OfferShare offerShare) async {
    String? token = SharedPrefService().getToken();
    OfferShareController _offerShareController =
        Provider.of<OfferShareController>(Get.context!, listen: false);
    _offerShareController.initProgress();
    try {
      d.Dio dio = d.Dio();
      d.Response response;
      // d.FormData formdata = d.FormData.fromMap(<String, dynamic>);
      response = await dio.post(
        baseUrl + "api/OfferShare",
        data: {
          "issuedDigitalShareId": offerShare.offerShareCompany.id,
          "offerTypeId": offerShare.type,
          "quantity": offerShare.quantity.toInt(),
          "offerPrice": offerShare.offerPrice,
          "offerTimeLimitId": offerShare.limitOffer.id,
          "offeredShareMainTypeId": offerShare.offeredShareMainTypeId
        },
        options: d.Options(headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }),
        onSendProgress: (int sent, int total) {
          log('progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');

          double p = double.parse((sent / total * 100).toStringAsFixed(0));

          if (p > 2 && p < 100) {
            p = p - 1;
          }
          _offerShareController.updateProgress(p);
        },
      );
      if (response.statusCode == 200) {
        log("add Offer Share=======>" + response.toString());
        return response;
      }
      //  Map<String, dynamic> data = {
      //   "issuedDigitalShareId": offerShare.offerShareCompany.id,
      //   "offerTypeId": offerShare.type,
      //   "quantity": offerShare.quantity.toInt(),
      //   "offerPrice": offerShare.offerPrice,
      //   "offerTimeLimitId": offerShare.limitOffer.id,
      // };

      // log("data ----- " + data.toString());

      // Uri url = Uri.parse(baseUrl + "api/OfferShare");
      // return await http.post(url,
      //     headers: {
      // "accept": "*/*",
      // "Content-Type": "application/json",
      // "Authorization": "Bearer $token"
      //     },
      //     body: json.encode(data));
    } on d.DioError catch (e) {
      if (e.response!.data != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

// ================================= Get Category ==============================

  //================================= Get All Offer Shares ====================================
  Future<http.Response> getOfferShares() async {
    String? token = SharedPrefService().getToken();
    Uri url = Uri.parse("${baseUrl}api/GetAllOfferedShares");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

//=================================== Get all bid Share ===================================
  Future<http.Response> getAllBidShare() async {
    String? token = SharedPrefService().getToken();
    Uri uri = Uri.parse(baseUrl + "api/GetAllBidShares");
    return await http
        .get(uri, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

  //================================= Get Payment Types ====================================
  Future<http.Response> getPaymentTypes() async {
    String? token = SharedPrefService().getToken();
    Uri url = Uri.parse("${baseUrl}api/GetAllPaymentTypes");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

  Future<http.Response> getPrimaryPaymentTypes() async {
    Uri url = Uri.parse("${baseUrl}api/GetAllPaymentTypes");
    return await http.get(url);
  }

  //================================= offer payment ====================================
  Future<d.Response?> offerPayment(OfferShareBid offerShare) async {
    String? token = SharedPrefService().getToken();
    OfferShareController _offerShareController =
        Provider.of<OfferShareController>(Get.context!, listen: false);
    _offerShareController.initProgress();
    try {
      d.Dio dio = d.Dio();
      d.Response response;
      response = await dio.post(
        baseUrl + "api/OfferPayment",
        data: {
          "paymentTypeId": offerShare.paymentMethod!.id,
          "offeredShareId": offerShare.id,
        },
        options: d.Options(
          headers: {
            "accept": "*/*",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
        onSendProgress: (int sent, int total) {
          print(
              'progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');

          double p = double.parse((sent / total * 100).toStringAsFixed(0));

          if (p > 2 && p < 100) {
            p = p - 1;
          }
          _offerShareController.updateProgress(p);
        },
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on d.DioError catch (e) {
      if (e.response!.data != null) {
        print(e.response!.data);
        print(e.response!.data);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
    // Map<String, dynamic> data = {
    // "paymentTypeId": offerShare.paymentMethod!.id,
    // "offeredShareId": offerShare.id,
    // };
    // Uri url = Uri.parse(baseUrl + "api/OfferPayment");
    // return await http.post(url,
    //     headers: {
    //       "accept": "*/*",
    //       "Content-Type": "application/json",
    //       "Authorization": "Bearer $token"
    //     },
    //     body: json.encode(data));
  }

//==========================================
  Future<d.Response?> BidShare(_quantityBidController, _bidPriceTwoController,
      _selectedPaymentType, _selectedOfferShare) async {
    String? token = SharedPrefService().getToken();

    try {
      String str = _bidPriceTwoController.text.trim();
      String bidPriceTwo = str.replaceAll(RegExp('[^0-9]'), '');
      d.Dio dio = d.Dio();
      d.Response response;
      response = await dio.post(
        baseUrl + "api/BidShare",
        data: {
          "quantity": _quantityBidController.text.trim(),
          "maximumBidPrice": bidPriceTwo,
          "paymentTypeId": _selectedPaymentType,
          "offeredShareId": _selectedOfferShare,
          "verificationStateId": "2"
        },
        options: d.Options(
          headers: {
            "accept": "*/*",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on d.DioError catch (e) {
      if (e.response!.data != null) {
        print(e.response!.data);
        print(e.response!.data);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        log(e.message);
      }
    }

    // Map<String, dynamic>
    //  data = {
    //   "quantity": _quantityBidController.text.trim(),
    //   "maximumBidPrice": _bidPriceTwoController.text.trim(),
    //   "paymentTypeId": _selectedPaymentType,
    //   "offeredShareId": _selectedOfferShare,
    //   "verificationStateId": "2"
    // };
    // Uri url = Uri.parse(baseUrl + "api/BidShare");
    // log("Bid Share ====================>" + data.toString());
    // return await http.post(url,
    //     headers: {
    //       "accept": "*/*",
    //       "Content-Type": "application/json",
    //       "Authorization": "Bearer $token"
    //     },
    //     body: json.encode(data));
  }

  //================================= get private shares ====================================
  Future<http.Response> getPrivateShares(String privateKey) async {
    String? token = SharedPrefService().getToken();
    Uri url = Uri.parse(
        "${baseUrl}api/GetPrivatelyOfferedShare?offerPrivateKey=$privateKey");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

  //============================ Get All Categories ==============================
  // Future<http.Response> getAllCategories() async {
  //   String? token = SharedPrefService().getToken();
  //   Uri url = Uri.parse("${baseUrl}api/GetAllCategories");
  //   return await http
  //       .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  // }
//============================ Get Secoundary Offer Data ==============================
  Future<d.Response?> getSecondaryOfferData(int offerShareBid) async {
    log("get offersharebid======" + offerShareBid.toString());
    String? token = SharedPrefService().getToken();
    try {
      d.Dio dio = d.Dio();
      d.Response response;
      response = await dio.post(baseUrl + "api/GetSecondaryOfferData",
          data: {"offeredShareId": offerShareBid},
          options: d.Options(
            headers: {
              "accept": "*/*",
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
          ));
      if (response.statusCode == 200) {
        log(" GetSecondaryOfferData ========" + response.toString());
        return response;
      }
    } on d.DioError catch (e) {
      if (e.response!.data != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

//========================= Get Primary Offer Data  List ===============================
  Future<http.Response> getPrimaryOfferData() async {
    String? token = SharedPrefService().getToken();
    log("Token======  " + token.toString());
    Uri url = Uri.parse(baseUrl + "api/GetPrimaryOffers");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }

//=========================Get Primary Offer Data PartiCular Comapany ================

  Future<http.Response> getPrimaryCompanyOfferData(String? companyId) async {
    String? token = SharedPrefService().getToken();
    log("Token======  " + token.toString());
    Uri url = Uri.parse(baseUrl + "api/GetPrimaryOffers?companyId=$companyId");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }
  // =========================== Bid On Primary Offer =================================

  Future<d.Response?> BidOnPrimaryOffers(_selectedPaymentType,
      _investmentController, _esign, _download, int? companyId) async {
    String? token = SharedPrefService().getToken();
    PrimaryOfferController _primaryOfferController =
        Provider.of<PrimaryOfferController>(Get.context!, listen: false);
    _primaryOfferController.initProgress();
    try {
      d.Dio dio = d.Dio();
      d.Response response;
      String str = _investmentController.text.trim();
      String investment = str.replaceAll(RegExp('[^0-9]'), '');
      log("investment====" + investment);
      response = await dio.post(
        baseUrl + "api/BidOnPrimaryOffer",
        data: {
          "companyId": companyId,
          "placementAmount": int.parse(investment).toString(),
          "paymentTypeId": _selectedPaymentType.toString(),
          "isESign": _esign,
          "isDownload": _download,
        },
        options: d.Options(
          headers: {
            "accept": "*/*",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
        onSendProgress: (int sent, int total) {
          log('progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');

          double p = double.parse((sent / total * 100).toStringAsFixed(0));

          if (p > 2 && p < 100) {
            p = p - 1;
          }
          _primaryOfferController.updateProgress(p);
        },
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on d.DioError catch (e) {
      if (e.response!.data != null) {
        print(e.response!.data);
        print(e.response!.data);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        log(e.message);
      }
    }
  }

// ============================= Get All BidsOnPrimaryOffer ============================
  Future<http.Response> getAllBidsOnPrimaryOffer() async {
    String? token = SharedPrefService().getToken();
    Uri url = Uri.parse(baseUrl + "api/GetAllBidsOnPrimaryOffer");
    return await http
        .get(url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});
  }
}
