class VerifyResponseModel {
  int? returnCode;
  String? returnMessage;
  bool? returnData;
  bool? returnStatus;

  VerifyResponseModel(
      {this.returnCode,
        this.returnMessage,
        this.returnData,
        this.returnStatus});

  VerifyResponseModel.fromJson(Map<String, dynamic> json) {
    returnCode = json['returnCode'];
    returnMessage = json['returnMessage'];
    returnData = json['returnData'];
    returnStatus = json['returnStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnCode'] = this.returnCode;
    data['returnMessage'] = this.returnMessage;
    data['returnData'] = this.returnData;
    data['returnStatus'] = this.returnStatus;
    return data;
  }
}
