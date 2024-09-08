class OfferShare {
  final DropDownItem offerShareCompany;
  final DropDownItem limitOffer;
  final double quantity;
  final double offerPrice;
  int? offeredShareMainTypeId;
  int? type;

  OfferShare({
    required this.offerShareCompany,
    required this.limitOffer,
    required this.quantity,
    required this.offerPrice,
    this.offeredShareMainTypeId,
    this.type,
  });
}

class DropDownItem {
  int id;
  final String value;

  DropDownItem(this.id, this.value);
}
