import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bursa_flutter/Services/api_services.dart';
import 'package:bursa_flutter/models/certificate_model.dart';
import 'package:bursa_flutter/models/getallIssues_share.dart';
import 'package:bursa_flutter/models/register_share_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../consts/color_const.dart';
import '../models/user_info_model.dart';

class IssueDigitalCertiController extends ChangeNotifier {
  double fileUploadProgress = 0;

  initProgress() {
    fileUploadProgress = 0;
  }

  updateProgress(double p) {
    fileUploadProgress = p;
    notifyListeners();
  }

  List<RegisterShareInfo>? _shareValueList;
  RegisterShareInfo? _selectedShareValue;
  List<IssueShareInfo>? _issueShareList;
  IssueShareInfo? _selectedIssueShareList;
  List<ReturnData>? _certificateList;
  ReturnData? _selectedcertificateList;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _shareNumberController = TextEditingController();
  TextEditingController _dateOfEmploymentController = TextEditingController();

  bool _certified = false;
  bool _nonCertified = true;

  bool _isAgree = false;

  List<ReturnData>? get certificateList => _certificateList;
  ReturnData? get selectedCertificateList => _selectedcertificateList;
  List<RegisterShareInfo>? get shareValueList => _shareValueList;
  RegisterShareInfo? get selectedShareValue => _selectedShareValue;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get middleNameController => _middleNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get companyNameController => _companyNameController;
  TextEditingController get shareNumberController => _shareNumberController;
  TextEditingController get dateOfEmploymentController =>
      _dateOfEmploymentController;
  bool get isAgree => _isAgree;
  bool get certified => _certified;
  bool get nonCertified => _nonCertified;
  List<IssueShareInfo>? get issueShareList => _issueShareList;
  IssueShareInfo? get selectedIssueShareList => _selectedIssueShareList;

  void setShareVlaue(RegisterShareInfo? data) {
    _selectedShareValue = data;
    notifyListeners();
  }

  void setIssueShareValue(IssueShareInfo? val) {
    _selectedIssueShareList = val;
    notifyListeners();
  }

  void setIsAgree(bool val) {
    _isAgree = val;
    notifyListeners();
  }

  void setCertified(bool data) {
    _certified = data;
    notifyListeners();
  }

  void setNonCertified(bool data) {
    _nonCertified = data;
    notifyListeners();
  }

  void reset() {
    _isAgree = false;
    _shareValueList = null;
    _selectedShareValue = null;
    _firstNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _companyNameController = TextEditingController();
    _shareNumberController = TextEditingController();
    _dateOfEmploymentController = TextEditingController();
  }

  RegisterShareInfo? _registerShareInfo;
  RegisterShareInfo? get registerShareInfo => _registerShareInfo;

//api call
  /// ======================= getRegister Share=============
  Future getRegisterShare() async {
    _shareValueList = [];
    var response = await ApiServices().getRegisterdSharesList();
    if (response.statusCode == 200) {
      RegisterdShare _data = registerdShareFromJson(response.body);

      List<RegisterShareInfo>? _dataList = _data.returnData;

      _dataList!.forEach((element) {
        if (element.verficationStatus == "Completed") {
          _shareValueList!.add(element);
        }
      });
      // _shareValueList = _data.returnData;
      log(_data.returnData.toString());
      notifyListeners();
    } else {
      _shareValueList = [];
      notifyListeners();
    }
  }

  ///======================getAllIssueShareCetificate=================
  Future getAllIssueshareCertificate() async {
    var response = await ApiServices().getAllIssuesShare();
    if (response.statusCode == 200) {
      log(response.body.toString());
      IssueShare _data = issueShareFromJson(response.body);
      _issueShareList = _data.returnData;
      log(_data.returnData.toString());
      notifyListeners();
    } else {
      log(response.toString());
      _issueShareList = [];
      notifyListeners();
    }
  }

  IssueCertificate? _issueCertificate;
  IssueCertificate? get issueCertificate => _issueCertificate;

  void setUserDetail(UserDetail detail) {
    _firstNameController = TextEditingController(text: detail.firstName);
    _dateOfEmploymentController =
        TextEditingController(text: _selectedShareValue!.dateOfGrant);
    _shareNumberController = TextEditingController(
        text: _selectedShareValue!.numberOfShares.toString());

    _companyNameController = TextEditingController(
        text: _selectedShareValue!.companyName.toString());
  }

  //=========================== issue Digital Certificate =======================================
  Future issueDigitalCertificate(File signature) async {
    var response = await ApiServices().issueDigitalShare(
        _selectedShareValue!.id,
        _firstNameController,
        // _lastNameController,
        // _middleNameController,
        _dateOfEmploymentController,
        _companyNameController,
        _certified,
        _shareNumberController,
        signature);
    if (response!.statusCode == 200) {
      // var decodedData = jsonDecode(response.data);
      var decodedData = response.data;

      if (decodedData['returnCode'] == 200 ||
          decodedData['returnCode'] == "200") {
        _issueCertificate = issueCertificateFromJson(json.encode(decodedData));
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
      return false;
    }
    //   if (response.statusCode == 200) {
    //     // log("response"+response.)
    //     log(response.statusCode.toString());
    //     log(response.toString());
    //     String data = await response.stream.bytesToString();

    //     log("Response --- " + data);

    //     var decodedData = json.decode(data);

    //     if (decodedData["returnCode"] == 200 ||
    //         decodedData["returnCode"] == "200") {
    //       _issueCertificate = issueCertificateFromJson(data);
    //       return true;
    //     } else {
    //       Fluttertoast.showToast(
    //         msg: decodedData["returnMessage"],
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: whiteColor,
    //         textColor: greenColor,
    //         fontSize: 15,
    //       );
    //       return false;
    //     }
    //   } else {
    //     log(response.statusCode.toString());
    //     return false;
    //   }
    // }
  }
}
