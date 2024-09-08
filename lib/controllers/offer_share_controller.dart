import 'dart:convert';
import 'dart:developer';
import 'package:bursa_flutter/models/Allpayment_model.dart';
import 'package:bursa_flutter/models/BidAllShare_model.dart';
import 'package:bursa_flutter/models/Limit_offer_model.dart';
import 'package:bursa_flutter/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:bursa_flutter/Services/api_services.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:bursa_flutter/models/offer_share1_model.dart';
import 'package:bursa_flutter/models/offer_share_model.dart';
import 'package:bursa_flutter/models/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../consts/color_const.dart';

class OfferShareController extends ChangeNotifier {
  double fileUploadProgress = 0;

  initProgress() {
    fileUploadProgress = 0;
  }

  updateProgress(double p) {
    fileUploadProgress = p;
    notifyListeners();
  }

  final _apiService = ApiServices();
  TextEditingController _quantityTextController = TextEditingController();
  TextEditingController _offerText = TextEditingController();
  List? _limitOffers;
  DropDownItem? _selectedLimitOffer;
  List? _companyShares;
  DropDownItem? _selectedCompanyShare;
  List? _paymentTypes;
  DropDownItem? _selectedPaymentType;
  double _bursaFees = 0;
  double _quantity = 0;
  double _offerPrice = 0;
  double _totalSalePrice = 0;
  List<OfferShareDetails>? _offerShareList;
  OfferShareDetails? _selectedOfferShare;
  bool _isConsent = false;
  bool _isConsent1 = false;

  bool get isConsent => _isConsent;
  bool get isConsent1 => _isConsent1;
  List<LimitDetails>? _limitDetails;
  LimitDetails? _selectedLimitdetails;
  TextEditingController _quantityBidController = TextEditingController();
  TextEditingController _bidPriceOneController = TextEditingController();
  TextEditingController _bidPriceTwoController = TextEditingController();
  TextEditingController _accountNameController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _ibnNumberController = TextEditingController();

  bool _private = false;
  bool _auction = true;

  bool get private => _private;
  bool get auction => _auction;

  List<LimitDetails>? get limitDetails => _limitDetails;
  LimitDetails? get selectedLimitDetails => _selectedLimitdetails;
  List<OfferShareDetails>? get offerShareList => _offerShareList;
  OfferShareDetails? get selectedOfferShare => _selectedOfferShare;
  TextEditingController get quantityBidController => _quantityBidController;

  TextEditingController get quantityTextController => _quantityTextController;
  TextEditingController get offerText => _offerText;
  TextEditingController get bidPriceOneController => _bidPriceOneController;
  TextEditingController get bidPriceTwoController => _bidPriceTwoController;
  TextEditingController get accountNameController => _accountNameController;
  TextEditingController get bankNameController => _bankNameController;
  TextEditingController get ibnNumberController => _ibnNumberController;

  List? get limitOffers => _limitOffers;

  DropDownItem? get selectedLimitOffer => _selectedLimitOffer;

  List? get companyShares => _companyShares;

  DropDownItem? get selectedCompanyShare => _selectedCompanyShare;

  List? get paymentTypes => _paymentTypes;

  DropDownItem? get selectedPaymentType => _selectedPaymentType;

  double get bursaFees => _bursaFees;

  double get quantity => _quantity;

  double get offerPrice => _offerPrice;

  double get totalSalePrice => _totalSalePrice;

  void reset() {
    _offerText = TextEditingController();
    _totalSalePrice = 0;
    _bursaFees = 0;
  }

  void resetBidPrice() {
    _bidPriceOneController = TextEditingController();
    _bidPriceTwoController = TextEditingController();
  }

  void resetAllData() {
    _selectedOfferShare = null;
    // _selectedLimitOffer = null;
    _selectedLimitdetails = null;
    _quantity = 0;

    // _selectedPaymentType = null;
    _offerText = TextEditingController();
    _quantityTextController = TextEditingController();
    _accountNameController = TextEditingController();
    _bankNameController = TextEditingController();
    _ibnNumberController = TextEditingController();
    _totalSalePrice = 0;
    _bursaFees = 0;
  }

  void setConsent(bool val) {
    _isConsent = val;
    notifyListeners();
  }

  void resetConsent() {
    _isConsent = false;
  }

  void resetConsent1() {
    _isConsent1 = false;
  }

  void setConsent1(bool val) {
    _isConsent1 = val;
    notifyListeners();
  }

  void resetDropdown() {
    _selectedLimitdetails = null;
  }

  void setPrivate() {
    _private = false;
    _auction = true;

    notifyListeners();
  }

  void setAction() {
    _private = true;
    _auction = false;

    notifyListeners();
  }

  set selectedLimitOffer(DropDownItem? value) {
    _selectedLimitOffer = value;
    notifyListeners();
  }

  set selectedCompanyShare(DropDownItem? value) {
    _selectedCompanyShare = value;

//  _quantityTextController = TextEditingController()

    notifyListeners();
  }

  set quantityBid(TextEditingController val) {
    _quantityBidController = val;
    notifyListeners();
  }

  void setselectedCompanyShares(OfferShareDetails? value) {
    _selectedOfferShare = value;

    log("value --- " + _selectedOfferShare.toString());
    _quantityTextController = TextEditingController(
        text: selectedOfferShare!.numberOfShares!.toString());
    reset();
    notifyListeners();
  }

  set selectedLimitOffers(LimitDetails? value) {
    _selectedLimitdetails = value;
    notifyListeners();
  }

  set selectedPaymentType(DropDownItem? value) {
    _selectedPaymentType = value;
    notifyListeners();
  }

  set quantity(double value) {
    _quantity = value;
    _calculateTotalSalePrice();
    notifyListeners();
  }

  set offerPrice(double value) {
    _offerPrice = value;
    _calculateTotalSalePrice();
    notifyListeners();
  }

  // getLimitOffers() async {
  //   var response = await _apiService.getOfferTimeLimits();
  //   if (response.statusCode == 200) {
  //     Map responseBody = jsonDecode(response.body);
  //     _limitOffers = responseBody['returnData']
  //         .map((e) => DropDownItem(e['id'], e['value']))
  //         .toList();
  //     _selectedLimitOffer =
  //         _limitOffers!.isNotEmpty ? _limitOffers?.first : null;
  //     notifyListeners();
  //   }
  // }

  Future<bool> getLimitOffers() async {
    http.Response response = await ApiServices().getOfferTimeLimits();
    if (response.statusCode == 200) {
      log("Response=-----------" + response.body);
      final responseJson = json.decode(response.body);
      if (responseJson['returnCode'] == 200 ||
          responseJson['returnCode'] == "200") {
        LimitInfo limitInfo = limitInfoFromJson(response.body);
        _limitDetails = limitInfo.returnData;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // getCompanyShares() async {
  //   var response = await _apiService.getCompanyShares();
  //   if (response.statusCode == 200) {
  //     Map responseBody = jsonDecode(response.body);
  //     _companyShares = responseBody['returnData']
  //         .map((e) => DropDownItem(e['Id'], e['CompanyName']))
  //         .toList();
  //     _selectedCompanyShare =
  //         _companyShares!.isNotEmpty ? _companyShares?.first : null;
  //     notifyListeners();
  //   }
  // }

  Future<bool> getCompanyShareWithOffer() async {
    http.Response response = await ApiServices().getCompanyShares();
    if (response.statusCode == 200) {
      log("Response  ---- " + response.body);
      final responseJson = json.decode(response.body);
      if (responseJson['returnCode'] == 200 ||
          responseJson['returnCode'] == "200") {
        OfferShareInfo offerShareInfo = offerShareInfoFromJson(response.body);

        _offerShareList = offerShareInfo.returnData;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  List<PaymentInfo>? _paymentList;
  PaymentInfo? _selectedPaymet;
  List<PaymentInfo>? get paymentList => _paymentList;
  PaymentInfo? get selectedPaymet => _selectedPaymet;

  Future<List<PaymentInfo>?> GetAllOfferedPayment() async {
    http.Response response = await ApiServices().getAllOfferedPayment();
    if (response.statusCode == 200) {
      log("Response ------------" + response.body);
      final responseJson = json.decode(response.body);
      if (responseJson['returnCode'] == 200 ||
          responseJson['returnCode'] == "200") {
        PaymentDetails paymentDetails = paymentDetailsFromJson(response.body);
        _paymentList = paymentDetails.returnData;
        notifyListeners();
        return _paymentList;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // getBursaFees() async {
  //   var response = await _apiService.getBursaFees();
  //   if (response.statusCode == 200) {
  //     Map responseBody = jsonDecode(response.body);
  //     _bursaFees = double.parse(responseBody['returnData'].toString());
  //     notifyListeners();
  //   }
  // }

  _calculateTotalSalePrice() =>
      _totalSalePrice = _selectedOfferShare!.numberOfShares! * _offerPrice;
  // _totalSalePrice = _quantity * _offerPrice;

  calculateBursaFee() => _bursaFees = _totalSalePrice * (1 / 100);

  // void setShareInfo(List<RegisterShareInfo>? registerSharesList) {
  //   _quantityTextController=TextEditingController(text: registerSharesList)
  // }

  Future<Map> addOfferShare() async {
    String str = offerText.text.trim();
    String offerPrice = str.replaceAll(RegExp('[^0-9]'), '');
    OfferShare share = OfferShare(
      offerShareCompany: DropDownItem(
          _selectedOfferShare!.id!, _selectedOfferShare!.companyName!),
      limitOffer: DropDownItem(
          _selectedLimitdetails!.id!, _selectedLimitdetails!.value!),
      quantity: double.parse(quantityTextController.text.trim()),
      offerPrice: double.parse(offerPrice),
      offeredShareMainTypeId: 2,
      type: _private ? 2 : 1,
    );
    var response = await _apiService.addOfferShare(share);
    log("decode ddata======= " + response!.data.toString());

    if (response.statusCode == 200) {
      var decodedData = response.data;
      if (decodedData['returnCode'] == 200 ||
          decodedData['returnCode'] == "200") {
        log(response.statusCode.toString());
        log(response.requestOptions.toString());
        log(response.toString());
        return {'success': true, 'key': decodedData['returnData']};
      }
      Fluttertoast.showToast(
        msg: decodedData['returnMessage'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: whiteColor,
        textColor: redColor,
        fontSize: 15,
      );
      return {'success': false, 'key': null};
    }
    return {'success': false, 'key': null};

    // log("Response ---- " + response.body);
    // if (response.statusCode == 200) {
    //   Map responseBody = jsonDecode(response.body);

    //   if (responseBody['returnCode'] != 200) {
    // Fluttertoast.showToast(
    //   msg: responseBody['returnMessage'],
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: whiteColor,
    //   textColor: redColor,
    //   fontSize: 15,
    // );
    //     return {'success': false, 'key': null};
    //   }

    //   return {'success': true, 'key': responseBody['returnData']};
    // }

    // return {'success': false, 'key': null};
  }

  Future<List<OfferShareBid>?> getOfferShares(UserDetail _detail) async {
    var response = await _apiService.getOfferShares();

    if (response.statusCode == 200) {
      log("response.body ---- " + response.body);
      Map responseBody = jsonDecode(response.body);
      List fetchedOfferShares = responseBody['returnData'];
      log("Response of offered share ----- " + fetchedOfferShares.toString());

      fetchedOfferShares.removeWhere((element) {
        if (element["offerType"] == "Private") {
          return true;
        } else {
          return false;
        }
      });
      List<OfferShareBid> offerShares = fetchedOfferShares.map((share) {
        List<int> payUsers = (share["bidUsers"] as List).map((element) {
          return int.parse(element.toString());
        }).toList();
        bool isPayed = payUsers.contains(_detail.userLoginId);

        return OfferShareBid(
            id: share['id'],
            isPayed: isPayed,
            logo: share['businessLogo'].toString(),
            companyName: share['companyName'],
            offerType: share['offerType'],
            quantity: share['quantity'],
            offerPrice: double.parse(share['offerPrice'].toString()),
            offerTimeLimit: share['offerTimeLimit'],
            offerShareMainTypeId: share["2"]
            // bidUsers: share["bidUsers"],
            );
      }).toList();

      offerShares.sort(((a, b) {
        return a.isPayed.toString().compareTo(b.isPayed.toString());
      }));

      return offerShares;
    }

    return null;
  }

  getPaymentTypes() async {
    var response = await _apiService.getPaymentTypes();
    if (response.statusCode == 200) {
      Map responseBody = jsonDecode(response.body);
      _paymentTypes = responseBody['returnData']
          .map((e) => DropDownItem(e['id'], e['value']))
          .toList();
      _selectedPaymentType =
          _paymentTypes!.isNotEmpty ? _paymentTypes?.first : null;
      notifyListeners();
    }
  }

  Future<Map> offerPayment(OfferShareBid offerShareBid) async {
    var response = await _apiService.offerPayment(offerShareBid);

    if (response!.statusCode == 200) {
      var decodedData = response.data;
      return {
        'success': decodedData['returnStatus'],
        'message': decodedData['returnMessage']
      };
    }
    return {
      'success': false,
      'message': 'API Error : ${response.statusCode} !'
    };

    // if (response.statusCode == 200) {
    //   Map responseBody = jsonDecode(response.body);
    //   log("Payment===============>" + response.body.toString());
    // return {
    //   'success': responseBody['returnStatus'],
    //   'message': responseBody['returnMessage']
    // };
    // }

    // return {
    //   'success': false,
    //   'message': 'API Error : ${response.statusCode} !'
    // };
  }

  OfferShareBid? _bidShare;
  OfferShareBid? get bidShare => _bidShare;

  void setSelectedBidShare(OfferShareBid? _selected) {
    _bidShare = _selected;
    notifyListeners();
  }

  void resetSelectedBidShare() {
    _bidShare = null;
  }

  Future<Map?> BidNewShare() async {
    var response = await ApiServices().BidShare(
        _quantityBidController,
        _bidPriceTwoController,
        _selectedPaymentType!.id.toString(),
        _bidShare!.id.toString());

    if (response!.statusCode == 200) {
      var decodeData = response.data;
      return decodeData;
    }

    // log("Bid Response =======" + response.body);
    // if (response.statusCode == 200) {
    //   Map responseBody = jsonDecode(response.body);
    //   return responseBody;
    // }
  }

  Future<OfferShareBid?>? getPrivateShare(String privateKey) async {
    var response = await _apiService.getPrivateShares(privateKey);
    log(response.body);
    if (response.statusCode == 200) {
      Map responseBody = jsonDecode(response.body);

      if (responseBody['returnCode'] != 200) {
        // Fluttertoast.showToast(
        //   msg: responseBody['returnMessage'],
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: whiteColor,
        //   textColor: redColor,
        //   fontSize: 15,
        // );

        return null;
      }

      Map fetchedPrivateShare = responseBody['returnData'];
      OfferShareBid shareBid = OfferShareBid(
        id: fetchedPrivateShare['id'],
        isPayed: fetchedPrivateShare.containsKey('isCompleted')
            ? fetchedPrivateShare['isCompleted']
            : false,
        logo: fetchedPrivateShare['businessLogo'].toString(),
        companyName: fetchedPrivateShare['companyName'],
        offerType: fetchedPrivateShare['offerType'],
        quantity: fetchedPrivateShare['quantity'],
        offerPrice: fetchedPrivateShare['offerPrice'],
        offerTimeLimit: fetchedPrivateShare['offerTimeLimit'],
        // bidUsers: fetchedPrivateShare["bidUsers"]
      );

      return shareBid;
    }

    return null;
  }

//========================== Get All BId Share================================

  List<BidShareDetails>? _bidShareDetails;
  BidShareDetails? _selectedBidShareDetails;
  BidShareDetails? get selectedBidShareDetails => _selectedBidShareDetails;
  List<BidShareDetails>? get bidshareDetails => _bidShareDetails;

  Future<List<BidShareDetails>?> getAllBidShares() async {
    try {
      var response = await ApiServices().getAllBidShare();

      log("Here ---------- " + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        log("Get All BidShare ===================>" +
            response.body.toLowerCase());
        if (responseJson['returnCode'] == 200 ||
            responseJson['returnCode'] == "returnCode") {
          BidShareInfo bidShareInfo = bidShareInfoFromJson(response.body);
          _bidShareDetails = bidShareInfo.returnData;
          // notifyListeners();
          return _bidShareDetails;
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
          // notifyListeners();
          return null;
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
        // notifyListeners();
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  List<CategoryInfoData>? _categoryInfoData;
  List<CategoryInfoData>? get categoryInfoData => _categoryInfoData;
  CategoryInfoData? _selectedCategoryInfoData;
  CategoryInfoData? get selectedCategoryInfoData => _selectedCategoryInfoData;

  void setSelectedCategoryInfoData(CategoryInfoData? _selected) {
    log("selected--->" + _selected!.content.toString());
    _selectedCategoryInfoData = _selected;
    log("selecteddsd--->" + _selected.content.toString());
    notifyListeners();
  }

  void resetSelectedCategoryInfoData() {
    _categoryInfoData = [];
  }

//==========================Get Secoundary offers================================

  Future<Map?> GetSecoundaryOffer(int offerShareBid) async {
    var response = await _apiService.getSecondaryOfferData(offerShareBid);

    if (response!.statusCode == 200) {
      final responseJson = json.decode(response.toString());
      if (responseJson['returnCode'] == 200 ||
          responseJson['returnCode'] == "200") {
        CategoryInfo categoryInfo = categoryInfoFromJson(response.toString());
        _categoryInfoData = categoryInfo.returnData;
        notifyListeners();
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
        _categoryInfoData = [];
        // notifyListeners();
      }
    } else {
      log("failed" + response.toString());
      Fluttertoast.showToast(
        msg: "Something went wrong!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: whiteColor,
        textColor: greenColor,
        fontSize: 15,
      );
      _categoryInfoData = [];
      // notifyListeners();
    }
  }
}

  // var response = await ApiServices().getPrimaryOfferData();
  // if (response.statusCode == 200) {
  //   final responseJson = json.decode(response.body);
  //   if (responseJson['returnCode'] == 200 ||
  //       responseJson['returnCode'] == "200") {
  //     log("sccessfll --->" + response.body);
  //     PrimaryOfferData primaryOfferData =
  //         primaryOfferDataFromJson(response.toString());
  //     _primaryOfferDataInfo = primaryOfferData.returnData;
  //     return _primaryOfferDataInfo;
  //   } else {
  //     Fluttertoast.showToast(
  //       msg: responseJson["returnMessage"],
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: whiteColor,
  //       textColor: greenColor,
  //       fontSize: 15,
  //     );
  //     return null;
  //   }
  // } else {
  //   log("message" + response.statusCode.toString());
  //   Fluttertoast.showToast(
  //     msg: "Something went wrong!",
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: whiteColor,
  //     textColor: greenColor,
  //     fontSize: 15,
  //   );
  //   return null;
  // }


  // Future<Map?> getPrimaryCategory() async {
  //   var response = await _apiService.getCategories("1");

  //   if (response!.statusCode == 200) {
  //     final responseJson = json.decode(response.toString());
  //     if (responseJson['returnCode'] == 200 ||
  //         responseJson['returnCode'] == "200") {
  //       CategoryInfo categoryInfo = categoryInfoFromJson(response.toString());
  //       _categoryInfoData = categoryInfo.returnData;
  //       notifyListeners();
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: responseJson["returnMessage"],
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: whiteColor,
  //         textColor: greenColor,
  //         fontSize: 15,
  //       );
  //       _categoryInfoData = [];
  //       // notifyListeners();
  //     }
  //   } else {
  //     log("failed" + response.toString());
  //     Fluttertoast.showToast(
  //       msg: "Something went wrong!",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: whiteColor,
  //       textColor: greenColor,
  //       fontSize: 15,
  //     );
  //     _categoryInfoData = [];
  //     // notifyListeners();
  //   }
  // }


