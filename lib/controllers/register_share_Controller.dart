import 'dart:developer';
import 'dart:io';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/models/grantType_model.dart';
import 'package:bursa_flutter/models/register_share_model.dart';
import 'package:bursa_flutter/models/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Services/api_services.dart';
import '../models/companies_model.dart';
import '../models/debtRound_model.dart';
import '../models/equty_model.dart';

class RegisterShareController extends ChangeNotifier {
  double fileUploadProgress = 0;

  initProgress() {
    fileUploadProgress = 0;
  }

  updateProgress(double p) {
    fileUploadProgress = p;
    notifyListeners();
  }

  // register_gant_first.dart
  TextEditingController _comapnyNameController = TextEditingController();
  // String? _companyValue;
  List<ComapaniesInfo>? _companiesList;
  ComapaniesInfo? _selectedCompanies;

  List<GrantTypeInfo>? _grantTypeList;
  GrantTypeInfo? _selectedGrantTypes;

  List<EquityRoundsInfo>? _equityRoundsList;
  EquityRoundsInfo? _selectedEquityRounds;

  File? _pdffile;
  File? _pdf1file;
  File? _photofile;
  //register_grant_type.dart

  String _selectedDebtRounds = 'Common';
  List<String>? _grantType;
  //register_grant_Equity.dart

  String _selectedDebtDebtsRound = "Mezanine";
  // List<String> _selectedEquityRounds = [];
  //register_shar_date.dart

  TextEditingController _numberofShareController = TextEditingController();
  TextEditingController _dateOfEmploymentController = TextEditingController();
  //register_grant_restrication.dart
  TextEditingController _rupeesController = TextEditingController();
  TextEditingController _lastValuation = TextEditingController();
  TextEditingController _grantValuation = TextEditingController();
  bool _isRestrication = false;
  bool _isRestrication1 = false;
  //register_person_info.dart
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String? _countryCode = "+971";
  //registerUploadScreen.dart
  String? _upload;
  bool _clickOn = false;
  List<RegisterShareInfo>? _registerSharesList;

//get the all value of data
  TextEditingController get comapnyNameController => _comapnyNameController;
  List<ComapaniesInfo>? get companiesList => _companiesList;
  ComapaniesInfo? get selectedConpanies => _selectedCompanies;
  List<GrantTypeInfo>? get grantTypeList => _grantTypeList;
  GrantTypeInfo? get selectedGrantType => _selectedGrantTypes;
  List<EquityRoundsInfo>? get equityRoundsList => _equityRoundsList;
  EquityRoundsInfo? get selectedEquityRounds => _selectedEquityRounds;

  // String? get companyValue => _companyValue;
  File? get pdffile => _pdffile;
  // String get selectedDebtRounds => _selectedDebtRounds;
  String get selectDebtsRounds => _selectedDebtDebtsRound;
  List<String>? get grantType => _grantType;
  // List<String> get selectedEquityRounds => _selectedEquityRounds;
  TextEditingController get numberofShareController => _numberofShareController;
  TextEditingController get dateOfEmploymentController =>
      _dateOfEmploymentController;
  TextEditingController get rupeesController => _rupeesController;
  TextEditingController get lastValuation => _lastValuation;
  TextEditingController get grantValuation => _grantValuation;
  bool get isRestrication => _isRestrication;
  bool get isRestrication1 => _isRestrication1;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneNumberController => _phoneNumberController;

  String? get countrycode => _countryCode;
  String? get upload => _upload;
  File? get padf1File => _pdf1file;
  File? get photofile => _photofile;
  bool get clickOn => _clickOn;
  List<RegisterShareInfo>? get registerSharesList => _registerSharesList;

  void resetData() {
    _comapnyNameController = TextEditingController();
    _companiesList = null;
    _selectedCompanies = null;
    _pdffile = null;
    _selectedDebtRounds = 'Common';
    _selectedDebtDebtsRound = "Mezanine";
    _selectedEquityRounds;
    _numberofShareController = TextEditingController();
    _dateOfEmploymentController = TextEditingController();
    _rupeesController = TextEditingController();
    _isRestrication = false;
    _isRestrication1 = false;
    _lastValuation = TextEditingController();
    _grantValuation = TextEditingController();
    _pdf1file = null;
    _photofile = null;
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _countryCode = null;
    _upload = null;
    _clickOn = false;
  }

  void setSelectedCompanies(ComapaniesInfo? data) {
    _selectedCompanies = data;
    notifyListeners();
  }

  void setCompanyname(TextEditingController data) {
    _comapnyNameController = data;
    notifyListeners();
  }

  //set comapny value method call on register_grant_first.dart
  // void setComapnValue(String? data) {
  //   _companyValue = data;
  //   notifyListeners();
  // }

  void setPdfFile(File? val) {
    _pdffile = val;
    notifyListeners();
  }

  void setPdf1File(File? val) {
    _pdf1file = val;
    notifyListeners();
  }

  void setPhotoFile(File? val) {
    _photofile = val;
    notifyListeners();
  }
  // set the selecteddebtRounds method call on register_grant_type.dart

  void setSelectedGrantType(GrantTypeInfo? data) {
    _selectedGrantTypes = data;
    notifyListeners();
  }

  // set the SelectsDebtRounds method call on register_grant_equity.dart

  void setSelectsDebtRounds(String data) {
    _selectedDebtDebtsRound = data;
    notifyListeners();
  }

  void setSelectedEquityRounds(EquityRoundsInfo? data) {
    _selectedEquityRounds = data;
    _selectedDebtRound = null;
    notifyListeners();
  }

  // void removeEquityRounds(EquityRoundsInfo? element) {
  //   _selectedEquityRounds!.remove(element);
  //   notifyListeners();
  // }

  // void addEquityRounds(EquityRoundsInfo elements) {
  //   _selectedEquityRounds!.add(elements);
  //   notifyListeners();
  // }

  //set the dateof Employment method call on register_shar_date.dart
  void setDateofEmployment(data) {
    _dateOfEmploymentController = data;
    notifyListeners();
  }

  //set the value of restrication method call on register_grant_restrication.dart
  void setIsConsent(bool val) {
    _isRestrication = val;
    notifyListeners();
  }

  void setIsConsent1(bool val) {
    _isRestrication1 = val;
    notifyListeners();
  }

// set the country code call on register_person_info.dart
  void setCountryCode(String? value) {
    _countryCode = value;
    notifyListeners();
  }

  //set the upload Method Call on registerUploadScreen.dart
  void setUpload(String? val) {
    _upload = val;
    notifyListeners();
  }

  void setClickOn(bool val) {
    _clickOn = val;
    notifyListeners();
  }

  // get Company List
  Future getCompanyList() async {
    var response = await ApiServices().getCompanyList();
    if (response.statusCode == 200) {
      CompaniesData _data = companiesDataFromJson(response.body);
      _companiesList = _data.returnData;
      notifyListeners();
    } else {
      _companiesList = [];
      notifyListeners();
    }
  }

  Future getGrantTypes() async {
    var response = await ApiServices().getGrantType();
    if (response.statusCode == 200) {
      GrantTypeData _data = grantTypeDataFromJson(response.body);
      _grantTypeList = _data.returnData;
      notifyListeners();
    } else {
      _grantTypeList = [];
      notifyListeners();
    }
  }

  Future getEquityRound() async {
    var response = await ApiServices().getEquityRounds();
    if (response.statusCode == 200) {
      EquityRounds _data = equityRoundsFromJson(response.body);
      _equityRoundsList = _data.returnData;
      notifyListeners();
    } else {
      _equityRoundsList = [];
      notifyListeners();
    }
  }

  List<DebtRoundInfo> _debtRoundList = [];
  DebtRoundInfo? _selectedDebtRound;

  List<DebtRoundInfo> get debtRoundList => _debtRoundList;
  DebtRoundInfo? get selectedDebtRound => _selectedDebtRound;

  void setSelectedDebtRound(DebtRoundInfo selectedDebt) {
    _selectedDebtRound = selectedDebt;
    _selectedEquityRounds = null;
    notifyListeners();
  }

  Future getDebtRounds() async {
    var response = await ApiServices().getDebtRound();
    if (response.statusCode == 200) {
      DebtRounds _data = debtRoundsFromJson(response.body);
      _debtRoundList = _data.returnData!;
      notifyListeners();
    } else {
      _equityRoundsList = [];
      notifyListeners();
    }
  }

  void setUserDetail(UserDetail detail) {
    _firstNameController = TextEditingController(text: detail.firstName);
    _emailController = TextEditingController(text: detail.email);
    _phoneNumberController = TextEditingController(text: detail.phoneNumber);
  }

// post api
//====================================== register New share ==========================================
  Future<bool> registerNewShare() async {
    var response = await ApiServices().registerShare(
        // _selectedCompanies!.id,
        _comapnyNameController,
        _selectedGrantTypes?.id ?? -1,
        _selectedEquityRounds?.id ?? -1,
        _selectedDebtRound?.id ?? -1,
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
        _pdffile,
        _pdf1file,
        _photofile);
    // log("Response statuscode----" + response.statusCode.toString());
    // String data = await response.stream.bytesToString();
    //
    // log("Response --- " + data);

    // var decodedData = json.decode(data);
    if (response != null) {
      var decodedData = response.data;
      if (response.statusCode == 200) {
        if (decodedData["returnCode"] == 201 ||
            decodedData["returnCode"] == "201") {
          log(response.statusCode.toString());
          log(response.requestOptions.toString());
          log(response.toString());

          return true;
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
        log("failed");
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
    }
    return false;
  }

  // Get registered share api

  Future getRegisterShares() async {
    try {
      var response = await ApiServices().getRegisteredShares();

      // log(response.body);
      if (response.statusCode == 200) {
        RegisterdShare _data = registerdShareFromJson(response.body);
        _registerSharesList = _data.returnData;
        notifyListeners();
      } else {
        _registerSharesList = [];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _registerSharesList = [];
      notifyListeners();
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
