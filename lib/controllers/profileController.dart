import 'package:bursa_flutter/models/user_info_model.dart';
import 'package:flutter/widgets.dart';

class ProfileController extends ChangeNotifier {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _cityNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _employementStatusController = TextEditingController();
  TextEditingController _incomeController = TextEditingController();
  TextEditingController _employernameController = TextEditingController();
  TextEditingController _dateofEmployementController = TextEditingController();
  TextEditingController _employedStatusController = TextEditingController();
  TextEditingController _experience = TextEditingController();
  TextEditingController _training = TextEditingController();
  TextEditingController _moreExperience = TextEditingController();

  TextEditingController _citizen = TextEditingController();
  TextEditingController _publicSector = TextEditingController();
  TextEditingController _indivisual = TextEditingController();
  TextEditingController _criminal = TextEditingController();
  TextEditingController _convicated = TextEditingController();
  String? _frontImg;
  String? _backImg;

  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get dateOfBirthController => _dateOfBirthController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get countryController => _countryController;
  TextEditingController get nationalityController => _nationalityController;
  TextEditingController get cityNameController => _cityNameController;
  TextEditingController get addressController => _addressController;
  TextEditingController get employementStatusController =>
      _employementStatusController;
  TextEditingController get incomeController => _incomeController;
  TextEditingController get employernameController => _employernameController;
  TextEditingController get dateofEmployementController =>
      _dateofEmployementController;
  TextEditingController get employesStatusController =>
      _employedStatusController;
  TextEditingController get experience => _experience;
  TextEditingController get training => _training;
  TextEditingController get moreExperience => _moreExperience;

  TextEditingController get citizen => _citizen;
  TextEditingController get publicSector => _publicSector;
  TextEditingController get indivisual => _indivisual;
  TextEditingController get criminal => _criminal;
  TextEditingController get convicated => _convicated;

  String? get frontImg => _frontImg;
  String? get backImg => _backImg;

  void setUserDetail(UserDetail detail) {
    _firstNameController = TextEditingController(text: detail.firstName);
    _emailController = TextEditingController(text: detail.email.toString());
    _dateOfBirthController =
        TextEditingController(text: detail.dateOfBirth.toString());
    _phoneController =
        TextEditingController(text: detail.phoneNumber.toString());
    _countryController = TextEditingController(text: detail.country);
    _nationalityController = TextEditingController(text: detail.nationality);
    _cityNameController = TextEditingController(text: detail.city);
    _addressController = TextEditingController(text: detail.addressLine);
    _employementStatusController =
        TextEditingController(text: detail.employementId);
    _incomeController =
        TextEditingController(text: detail.annualIncome.toString());
    _employernameController = TextEditingController(text: detail.employerName);
    _dateofEmployementController =
        TextEditingController(text: detail.dateOfEmployement.toString());
    _employedStatusController =
        TextEditingController(text: detail.employementId);
    _experience = TextEditingController(
        text: detail.havePriorExpirence == true ? "Yes" : "No".toString());
    _training = TextEditingController(
        text: detail.haveTraining == true ? "Yes" : "No".toString());
    _moreExperience = TextEditingController(
        text: detail.haveExperience == true ? "Yes" : "No".toString());

    _citizen = TextEditingController(
        text: detail.isUsCitizen == true ? "Yes" : "No".toString());
    _publicSector = TextEditingController(
        text: detail.isPublicSectorEmployee == true ? "Yes" : "No".toString());
    _indivisual = TextEditingController(
        text: detail.isIndividual == true ? "Yes" : "No".toString());
    _criminal = TextEditingController(
        text: detail.haveCriminalRecord == true ? "Yes" : "No".toString());
    _convicated = TextEditingController(
        text: detail.haveConvicted == true ? "Yes" : "No".toString());
    _frontImg = (detail.emiratesIdPictureFront);
    _backImg = (detail.emiratesIdPictureBack);
  }
}
