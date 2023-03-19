class ChargeCodeModel {
  int? code;
  String? message;
  Data? data;

  ChargeCodeModel({this.code, this.message, this.data});

  ChargeCodeModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? gold;
  String? cash;
  int? useNum;
  int? usedNum;

  Data({this.id, this.gold, this.cash, this.useNum, this.usedNum});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gold = json['gold'];
    cash = json['cash'];
    useNum = json['use_num'];
    usedNum = json['used_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gold'] = this.gold;
    data['cash'] = this.cash;
    data['use_num'] = this.useNum;
    data['used_num'] = this.usedNum;
    return data;
  }
}
