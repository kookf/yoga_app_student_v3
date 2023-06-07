class PaymentCompleteModel {
  int? code;
  String? message;
  Data? data;

  PaymentCompleteModel({this.code, this.message, this.data});

  PaymentCompleteModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? chargeId;
  String? image;
  String? orderNo;
  String? createdAt;
  String? updatedAt;
  String? clientIp;
  int? userId;
  int? codeId;
  String? amount;
  String? gold;
  int? isShareWallet;
  int? id;

  Data(
      {this.chargeId,
      this.image,
      this.orderNo,
      this.createdAt,
      this.updatedAt,
      this.clientIp,
      this.userId,
      this.codeId,
      this.amount,
      this.gold,
      this.isShareWallet,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    chargeId = json['charge_id'];
    image = json['image'];
    orderNo = json['order_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    clientIp = json['client_ip'];
    userId = json['user_id'];
    codeId = json['code_id'];
    amount = json['amount'];
    gold = json['gold'];
    isShareWallet = json['is_share_wallet'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charge_id'] = this.chargeId;
    data['image'] = this.image;
    data['order_no'] = this.orderNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['client_ip'] = this.clientIp;
    data['user_id'] = this.userId;
    data['code_id'] = this.codeId;
    data['amount'] = this.amount;
    data['gold'] = this.gold;
    data['is_share_wallet'] = this.isShareWallet;
    data['id'] = this.id;
    return data;
  }
}
