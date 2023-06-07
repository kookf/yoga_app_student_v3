class PaymentMethodModel {
  int? code;
  String? message;
  Data? data;

  PaymentMethodModel({this.code, this.message, this.data});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
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
  List<PaymentMethodList>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <PaymentMethodList>[];
      json['list'].forEach((v) {
        list!.add(PaymentMethodList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethodList {
  int? id;
  String? name;
  var gold;
  String? amount;
  int? isShareWallet;

  PaymentMethodList(
      {this.id, this.name, this.gold, this.amount, this.isShareWallet});

  PaymentMethodList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gold = json['gold'];
    amount = json['amount'];
    isShareWallet = json['is_share_wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gold'] = this.gold;
    data['amount'] = this.amount;
    data['is_share_wallet'] = this.isShareWallet;
    return data;
  }
}
