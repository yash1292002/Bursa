import 'offer_share_model.dart';

class OfferShareBid {
  final int id;
  final String logo;
  final String companyName;
  final String offerType;
  final int quantity;
  final double offerPrice;
  final String offerTimeLimit;
  final bool isPayed;
  final String? offerShareMainTypeId;

  double? bidQuantity;
  double? minBidPrice;
  double? maxBidPrice;
  String? limitBid;
  DropDownItem? paymentMethod;
  bool? thirdPartyDeclaration;
  // List? bidUsers;

  OfferShareBid({
    required this.id,
    required this.logo,
    required this.companyName,
    required this.offerType,
    required this.quantity,
    required this.offerPrice,
    required this.offerTimeLimit,
    required this.isPayed,
    this.offerShareMainTypeId,
    // required this.bidUsers,
  });
}
