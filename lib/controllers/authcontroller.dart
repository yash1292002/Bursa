import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:bursa_flutter/Services/shared_pref_services.dart';
import 'package:bursa_flutter/models/user_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:bursa_flutter/Services/api_services.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/models/employement_model.dart';
import 'package:bursa_flutter/models/nationalities_model.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../models/country_model.dart';

class AuthController extends ChangeNotifier {
  String? _emirateId;
  //sign in screen
  TextEditingController _emailOrPhoneController = TextEditingController();

  PageController? _controller;
  // var _portrait;
  // File? _docImage;
  File? _frontImage;
  File? _backImage;
  List<CountryInfo>? _countryList;
  CountryInfo? _selectedCountry;
  List<NationalityInfo>? _nationalityList;
  NationalityInfo? _selectedNationality;
  bool _isConsent = false;

  TextEditingController _fullNameController = TextEditingController();
  // TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _birthOfDateController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String? _countryCode = "+971";

  //registeration_address.dart
  TextEditingController _cityNameController = TextEditingController();
  TextEditingController _addressNameController = TextEditingController();

  String? _nationality;
  String? _country;
  //registerastion_income.dart
  TextEditingController _incomeTextController = TextEditingController();
  TextEditingController _employeeNameController = TextEditingController();
  TextEditingController _dateOfEmploymentController = TextEditingController();
  List<EmployementInfo>? _employementList;
  EmployementInfo? _selectedEmployement;
//register_education.dart
//String? _employement1;
  List<String?> _educationAnswers = [];
//registration_kyc.dart
  List<String?> _kycAnswers = [];
//registration_verify.dart
  TextEditingController _pinController = TextEditingController();
  //registration_pin.dart
  List<TextEditingController>? _otpControllers;
  List<TextEditingController>? _otpController1;
  PageController? get controller => _controller;

  File? get frontImage => _frontImage;
  File? get backImage => _backImage;

  String? get emirateId => _emirateId;

  void setEmiratedId(String emirateId) {
    _emirateId = emirateId;
    notifyListeners();
  }

  TextEditingController get emialOrPhoneController => _emailOrPhoneController;
  List<CountryInfo>? get countryList => _countryList;
  CountryInfo? get selectedCountry => _selectedCountry;
  List<NationalityInfo>? get nationalitiesList => _nationalityList;
  NationalityInfo? get selectedNationality => _selectedNationality;
  List<EmployementInfo>? get employementInfoList => _employementList;
  EmployementInfo? get selectedEmployement => _selectedEmployement;
  TextEditingController get fullNameController => _fullNameController;
  // TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get birthofdateController => _birthOfDateController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  String? get countrycode => _countryCode;

  TextEditingController get cityNameController => _cityNameController;
  TextEditingController get addressNameController => _addressNameController;
  String? get nationality => _nationality;
  String? get country => _country;
  TextEditingController get incomeTextController => _incomeTextController;
  TextEditingController get employeeNameController => _employeeNameController;
  TextEditingController get dateOfEmploymentController =>
      _dateOfEmploymentController;
  // String? get emaployement => _employement;
  //String? get emaployement1=> _employement1;
  List<String?> get educationAnswers => _educationAnswers;
  List<String?> get kycAnswers => _kycAnswers;
  TextEditingController get pinController => _pinController;
  List<TextEditingController>? get otpControllers => _otpControllers;
  List<TextEditingController>? get otpController1 => _otpController1;
  bool get isconsent => _isConsent;

  void initPageController() {
    _controller = PageController();
  }

  void setConsent(bool val) {
    _isConsent = val;
    notifyListeners();
  }

  void reset() {
    _fullNameController = TextEditingController();
    // _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _birthOfDateController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _cityNameController = TextEditingController();
    _addressNameController = TextEditingController();
    _incomeTextController = TextEditingController();
    _employeeNameController = TextEditingController();
    _dateOfEmploymentController = TextEditingController();
    _pinController = TextEditingController();
    _frontImage = null;
    _backImage = null;
    _countryList = null;
    _selectedCountry = null;
    _nationalityList = null;
    _selectedNationality = null;
    _employementList = null;
    _selectedEmployement = null;
    _countryCode = null;
    _nationality = null;
    _country = null;
    _educationAnswers = [];
    _kycAnswers = [];
    _otpControllers = null;
    _isConsent = false;
  }

  void resetLoginInfo() {
    _emailOrPhoneController = TextEditingController();
  }

  void initOtpController(List<TextEditingController>? controllers) {
    _otpControllers = controllers;
  }

  void initOtpController1(List<TextEditingController>? controllers) {
    _otpController1 = controllers;
  }

  void initEducation(List<String?>? controller) {
    _educationAnswers = controller!;
  }

  void initKycAnswer(List<String?>? controller) {
    _kycAnswers = controller!;
  }

  // void setKyc(bool data) {
  //   _kycAnswers != data;
  //   notifyListeners();
  // }
  // void setDocimg( value){
  //   _frontImage = value;
  //   notifyListeners();
  // }

  //set front image and set baack Image methd call on register_id_proof.dart
  void setFrountImage(File? val) {
    _frontImage = val;
    notifyListeners();
  }

  void resetFrontImage() {
    _frontImage = null;
    _backImage = null;
    // notifyListeners();
  }

  void setBackImage(File? val) {
    _backImage = val;
    notifyListeners();
  }

// set the country code call on register_personal_details.dart
  void setCountryCode(String? value) {
    _countryCode = value;
    notifyListeners();
  }

// set the employement call on register_address.dart,
  void setEmployement(EmployementInfo? data) {
    _selectedEmployement = data;
    notifyListeners();
  }

//set the nationality call on register_address.dart
  void setNationality(NationalityInfo? data) {
    _selectedNationality = data;
    notifyListeners();
  }

  void setCounty(String? data) {
    _country = data;
    notifyListeners();
  }

  void setCountry(CountryInfo? data) {
    _selectedCountry = data;
    notifyListeners();
  }

  // Set the value of username and password from the shared preferance.
  void init() {
    String? userName = SharedPrefService().getUserName();
    String? password = SharedPrefService().getPassword();

    log("userNamne ----  + " + userName.toString());

    if (userName != null && password != null) {
      _emailOrPhoneController = TextEditingController(text: userName);
      // for (var item in _otpController1!) {
      //   item.text = password[]

      // }

      _otpController1 = List.generate(4, (index) => TextEditingController());
      for (var i = 0; i < _otpController1!.length; i++) {
        _otpController1![i].text = password[i];
      }
    }
  }

// ========================================================> Api Section <=======================================
// =====================================  get country Api =======================================
  Future getCountryId() async {
    var response = await ApiServices().getCountryList();
    if (response.statusCode == 200) {
      CountryData _data = countryDataFromJson(response.body);
      _countryList = _data.returnData;
      // notifyListeners();
    } else {
      _countryList = [];
      // notifyListeners();
    }
  }

//====================================== get Nationalites api =======================================
  Future getNationalities() async {
    var response = await ApiServices().getNationalitiesList();
    if (response.statusCode == 200) {
      NationalitiesData _data = nationalitiesDataFromJson(response.body);
      _nationalityList = _data.returnData;
      // notifyListeners();
    } else {
      _nationalityList = [];
      // notifyListeners();
    }
  }

//====================================== get Employement Api ==========================================
  Future getEmployementData() async {
    var response = await ApiServices().getEmployementDataList();
    if (response.statusCode == 200) {
      EmployementData _data = employementDataFromJson(response.body);
      _employementList = _data.returnData;
      // notifyListeners();
    } else {
      _employementList = [];
      // notifyListeners();
    }
  }

  String _ibanNumber = "";
  String _vaultId = "";

  String get ibanNumber => _ibanNumber;
  String get vaultId => _vaultId;

  ///==================================== New User Register api ==========================================
  Future registerNewUser() async {
    var response = await ApiServices().registerUser(
        _fullNameController,
        // _lastNameController,
        _emailController,
        _birthOfDateController,
        _phoneNumberController,
        _kycAnswers,
        _cityNameController,
        _addressNameController,
        _selectedCountry!.id,
        _selectedNationality!.id,
        _selectedEmployement!.id,
        _incomeTextController,
        _dateOfEmploymentController,
        _educationAnswers,
        _otpControllers,
        _employeeNameController,
        _emirateId,
        _frontImage,
        _backImage);

    print("Response statuscode ----- " + response.statusCode.toString());
    // log(response.statusCode.toString());
    // String data = await response.stream.bytesToString();

    // log("Response --- " + data);
    if (response.statusCode == 200) {
      print("image upload");

      print(response.statusCode.toString());
      String data = await response.stream.bytesToString();

      // log("Response --- " + data);

      var decodedData = json.decode(data);

      if (decodedData["returnCode"] == 201 ||
          decodedData["returnCode"] == "201") {
        _vaultId = decodedData["returnData"]["vaultNumber"];
        _ibanNumber = decodedData["returnData"]["ibanNumber"];
        // return true;

        try {
          // return true;

          String passCode1 = "";
          for (var item in _otpControllers!) {
            passCode1 += item.text.trim();
          }

          Map<String, dynamic> body = {
            "emailOrPhone": emailController.text.trim(),
            "passcode": passCode1
          };

          log("request body " + body.toString());

          final response = await ApiServices().loginUser(body);
          final responseJson = json.decode(response.body);

          if (response.statusCode == 200) {
            print("succssful" + response.body);
            // response;

            if (responseJson['returnCode'] == 202 ||
                responseJson["returnCode"] == "202") {
              SharedPrefService()
                  .setToken(responseJson["returnData"]["AccessToken"]);
              SharedPrefService()
                  .setRefreshToken(responseJson["returnData"]["RefreshToken"]);
              SharedPrefService().setUserName(emailController.text.trim());
              SharedPrefService().setPassword(passCode1);

              log("Token ---- " + SharedPrefService().getToken()!);

              return true;
            } else {
              Fluttertoast.showToast(
                msg: responseJson["returnMessage"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: whiteColor,
                textColor: greenColor,
                fontSize: 15,
              );
              return false;
            }
          } else {
            log("failed" + response.body);

            Fluttertoast.showToast(
              msg: "Something went wrong!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: whiteColor,
              textColor: greenColor,
              fontSize: 15,
            );
            return false;
          }
        } catch (e) {
          print(e);
          Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: whiteColor,
            textColor: greenColor,
            fontSize: 15,
          );
          return false;
        }
      } else {
        Fluttertoast.showToast(
          msg: decodedData["returnMessage"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: whiteColor,
          textColor: greenColor,
          fontSize: 15,
        );
        return false;
      }
    } else {
      print("image faild");
      String data = await response.stream.bytesToString();
      log("Error --- " + data);
      Fluttertoast.showToast(
        msg: response.request.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: whiteColor,
        textColor: greenColor,
        fontSize: 15,
      );
      return false;
    }
  }

// ======================================= get Company List ================================================
  Future getCompanyList() async {
    var response = await ApiServices().getCompanyList();
    if (response.statusCode == 200) {}
  }

//========================================= Login api ========================================================
  Future<bool> loginNewUser() async {
    String passCode = "";
    for (var item in _otpController1!) {
      passCode += item.text.trim();
    }

    // var url = "https://backoffice-stage.getbursa.com/api/Auth";
    var url = "https://origin-stage.getbursa.com/api/Auth";
    var body = json.encode({
      "emailOrPhone": _emailOrPhoneController.text.trim(),
      "passcode": passCode
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    final response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    final responseJson = json.decode(response.body);
    // print(responseJson);
    if (response.statusCode == 200) {
      log("succssful" + response.body);
      // response;

      if (responseJson['returnCode'] == 202 ||
          responseJson["returnCode"] == "202") {
        SharedPrefService().setToken(responseJson["returnData"]["AccessToken"]);
        SharedPrefService()
            .setRefreshToken(responseJson["returnData"]["RefreshToken"]);
        SharedPrefService().setUserName(_emailOrPhoneController.text.trim());
        SharedPrefService().setPassword(passCode);

        log("Token ---- " + SharedPrefService().getToken()!);

        return true;
      } else {
        Fluttertoast.showToast(
          msg: responseJson["returnMessage"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: whiteColor,
          textColor: greenColor,
          fontSize: 15,
        );
        return false;
      }
    } else {
      print("failed" + response.body);

      Fluttertoast.showToast(
        msg: "Something went wrong!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: whiteColor,
        textColor: greenColor,
        fontSize: 15,
      );
      return false;
    }
  }

  // ======================================forgate passcode ===================================================
  Future<bool> forgetPassCodes() async {
    Map<String, dynamic> data = {"email": _emailOrPhoneController.text.trim()};
    http.Response response = await ApiServices().forgetPassCode(data);
    log(response.body.toString());
    final responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseJson['returnCode'] == 202 ||
          responseJson['returnCode'] == "202") {
        Fluttertoast.showToast(
          msg: responseJson["returnMessage"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: whiteColor,
          textColor: greenColor,
          fontSize: 15,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: responseJson["returnMessage"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: whiteColor,
          textColor: greenColor,
          fontSize: 15,
        );
        return false;
      }
    } else {
      Fluttertoast.showToast(
        msg: "Something went to wrong!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: whiteColor,
        textColor: greenColor,
        fontSize: 15,
      );

      return false;
    }
  }

  // =======================================Send Otp Api=====================================================

  String _otp = "";
  String get otp => _otp;

  Future<bool> sendOtp() async {
    try {
      String rndnumber = "";
      var rnd = math.Random();
      for (var i = 0; i < 4; i++) {
        rndnumber = rndnumber + rnd.nextInt(9).toString();
      }
      // print(rndnumber);
      log("Random otp --- " + rndnumber);
      Map<String, dynamic> data = {
        "email": _emailController.text.trim(),
        "phoneNumber": _phoneNumberController.text.trim(),
        "otp": rndnumber.toString()
      };

      log("data   " + data.toString());
      http.Response response = await ApiServices().sendOtp(data);

      log(response.body.toString());

      if (response.statusCode == 200) {
        _otp = rndnumber;
        Fluttertoast.showToast(
          msg: "Please check you mail for otp",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: whiteColor,
          textColor: greenColor,
          fontSize: 15,
        );
        notifyListeners();
        return true;
      } else {
        // final responseJson = json.decode(response.body);
        Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: whiteColor,
          textColor: greenColor,
          fontSize: 15,
        );
        notifyListeners();
        return false;
      }
    } catch (e) {
      log(e.toString());
      notifyListeners();
      Fluttertoast.showToast(
        msg: "Something went wrong!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: whiteColor,
        textColor: greenColor,
        fontSize: 15,
      );
      return false;
    }
  }

//========================================== verify otp ======================================================
  Future<bool> verifyOtp() async {
    String passCode = _pinController.text.trim();

    if (passCode == _otp) {
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(
        msg: "Invalid OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: whiteColor,
        textColor: greenColor,
        fontSize: 15,
      );
      return false;
    }

    // return true;
  }

//========================================== refresh token ====================================================
  Future refreshToken() async {
    try {
      http.Response data = await ApiServices().refreshToken();

      if (data.statusCode == 200) {
        final responseJson = json.decode(data.body);

        log("responseJson ---- " + data.body.toString());

        if (responseJson['returnCode'] == 202 ||
            responseJson["returnCode"] == "202") {
          SharedPrefService()
              .setToken(responseJson["returnData"]["AccessToken"]);
          SharedPrefService()
              .setRefreshToken(responseJson["returnData"]["RefreshToken"]);
          log("Token ---- " + SharedPrefService().getToken()!);
          notifyListeners();
          return true;
        } else {
          Fluttertoast.showToast(
            msg: responseJson["returnMessage"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: whiteColor,
            textColor: greenColor,
            fontSize: 15,
          );
          notifyListeners();
          return false;
        }
      } else {
        log("failed" + data.body);
        Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: whiteColor,
          textColor: greenColor,
          fontSize: 15,
        );
        notifyListeners();
        return false;
      }
    } catch (e) {
      log(e.toString());
      notifyListeners();
    }
  }

  //=============================================== get user info ================================================
  UserDetail? _userDetail;
  UserDetail? get userDetail => _userDetail;

  Future<bool> getUserInfo() async {
    try {
      http.Response response = await ApiServices().getUserInfo();

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        log("responseJson ---- " + response.body.toString());

        if (responseJson['returnCode'] == 200 ||
            responseJson["returnCode"] == "200") {
          // SharedPrefService()
          //     .setToken(responseJson["returnData"]["AccessToken"]);
          // SharedPrefService()
          //     .setRefreshToken(responseJson["returnData"]["RefreshToken"]);
          // log("Token ---- " + SharedPrefService().getToken()!);

          UserInfo userInfo = userInfoFromJson(response.body);
          _userDetail = userInfo.returnData;

          notifyListeners();
          return true;
        } else {
          Fluttertoast.showToast(
            msg: responseJson["returnMessage"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: whiteColor,
            textColor: greenColor,
            fontSize: 15,
          );
          notifyListeners();
          return false;
        }
      } else {
        log("failed" + response.body);
        Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: whiteColor,
          textColor: greenColor,
          fontSize: 15,
        );
        notifyListeners();
        return false;
      }
    } catch (e) {
      log(e.toString());
      notifyListeners();
      return false;
    }
  }

  String convertDateFormat(
      String dateTimeString, String oldFormat, String newFormat) {
    DateFormat newDateFormat = DateFormat(newFormat);
    DateTime dateTime = DateFormat(oldFormat).parse(dateTimeString);
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}
