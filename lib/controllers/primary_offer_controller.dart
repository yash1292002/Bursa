import 'dart:developer';

import 'package:bursa_flutter/Services/api_services.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/models/getAllBid_offerShare.dart';
import 'package:bursa_flutter/models/getAll_primary_model.dart';
import 'package:bursa_flutter/models/get_primary_company_model.dart';
import 'package:bursa_flutter/models/payment_type_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class PrimaryOfferController extends ChangeNotifier {
  double fileUploadProgress = 0;

  initProgress() {
    fileUploadProgress = 0;
  }

  updateProgress(double p) {
    fileUploadProgress = p;
    notifyListeners();
  }

  TextEditingController _investmentController = TextEditingController();
  bool _esign = false;
  bool _download = false;
  bool _thirdParty = false;
  bool _agre = false;
  bool _agre1 = false;
  bool _consent = false;

  bool get esign => _esign;
  bool get download => _download;
  bool get thirdParty => _thirdParty;
  bool get agre => _agre;
  bool get agre1 => _agre1;
  bool get consent => _consent;

  void resetPrimaryData() {
    _investmentController = TextEditingController();
    _esign = false;
    _download = false;
    _thirdParty = false;
    _agre = false;
    _agre1 = false;
    _consent = false;
  }

  void setEsign() {
    _esign = !_esign;
    notifyListeners();
  }

  void setDownload() {
    _download = !_download;
    notifyListeners();
  }

  void setThirdParty() {
    _thirdParty = !_thirdParty;
    notifyListeners();
  }

  void setAgre() {
    _agre = !_agre;
    notifyListeners();
  }

  void setAgre1() {
    _agre1 = !_agre1;
    notifyListeners();
  }

  void setConsent(bool val) {
    _consent = val;
    notifyListeners();
  }

  // }
//  String val = primaryOfferDataInfo![index].companyInfo[0].value;
//  List<String> list = val.split(",");

  TextEditingController get investmentController => _investmentController;

  List<PrimaryOfferDataInfo>? _primaryOfferDataInfo;
  List<PrimaryOfferDataInfo>? get primaryOfferDataInfo => _primaryOfferDataInfo;

  Future GetPrimaryOfferDatas() async {
    var response = await ApiServices().getPrimaryOfferData();
    if (response.statusCode == 200) {
      PrimaryOfferData _data = primaryOfferDataFromJson(response.body);
      _primaryOfferDataInfo = _data.returnData;

      notifyListeners();

      primaryOfferDataInfo!.sort(((a, b) {
        return b.investorDto.toString().compareTo(a.investorDto.toString());
      }));

      return primaryOfferDataInfo;
    } else {
      _primaryOfferDataInfo = [];
      notifyListeners();
    }
  }

//============================================== get Primary Company Offer Data ======================================================
  List<PrimaryCompanyInfo>? _primaryCompanyInfo;
  List<PrimaryCompanyInfo>? get primaryCompanyInfo => _primaryCompanyInfo;
  Future getPrimaryCompanyOffer(String? companyId) async {
    try {
      var response = await ApiServices().getPrimaryCompanyOfferData(companyId);
      if (response.statusCode == 200) {
        PrimaryCompany _data = primaryCompanyFromJson(response.body);
        _primaryCompanyInfo = _data.returnData;
        notifyListeners();
      } else {
        _primaryCompanyInfo = [];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _primaryCompanyInfo = [];
      notifyListeners();
    }
  }

//=============================================== get All Primary Bid Share ====================================================
  List<BidPrimaryOfferDataInfo>? _bidPrimaryOfferData;
  List<BidPrimaryOfferDataInfo>? get bidPrimaryOfferData =>
      _bidPrimaryOfferData;
  Future getAllBidsOnPrimaryOffers() async {
    try {
      var response = await ApiServices().getAllBidsOnPrimaryOffer();
      if (response.statusCode == 200) {
        BidPrimaryOfferData _data = bidPrimaryOfferDataFromJson(response.body);
        _bidPrimaryOfferData = _data.returnData;
        notifyListeners();
      } else {
        _bidPrimaryOfferData = [];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _bidPrimaryOfferData = [];
      notifyListeners();
    }
  }

//========================================== get Payment Details ================================================================
  List<PaymentTypeInfo>? _paymentTypelist;
  List<PaymentTypeInfo>? get paymentTypeList => _paymentTypelist;
  PaymentTypeInfo? _selectedPaymentType;
  PaymentTypeInfo? get selectedPaymentType => _selectedPaymentType;

  void setPaymentType(PaymentTypeInfo? data) {
    _selectedPaymentType = data;
    notifyListeners();
  }

  void resetPaymentType() {
    _selectedPaymentType = null;
  }

  Future getPrimaryPaymentType() async {
    var response = await ApiServices().getPrimaryPaymentTypes();
    if (response.statusCode == 200) {
      PaymentType _data = paymentTypeFromJson(response.body);
      _paymentTypelist = _data.returnData;
    } else {
      _paymentTypelist = [];
    }
  }

//=========================================== Bid Primary Offer ================================================================
  Future<bool?> BidPrimaryOffer(int? companyId) async {
    var response = await ApiServices().BidOnPrimaryOffers(
        _selectedPaymentType!.id,
        _investmentController,
        _esign,
        _download,
        companyId);

    if (response != null) {
      var decodedData = response.data;
      if (response.statusCode == 200) {
        if (decodedData['returnCode'] == 200 ||
            decodedData['returnCode'] == "200") {
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
  }

  String convertDateFormat(
      String dateTimeString, String oldFormat, String newFormat) {
    DateFormat newDateFormat = DateFormat(newFormat);
    DateTime dateTime = DateFormat(oldFormat).parse(dateTimeString);
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}
