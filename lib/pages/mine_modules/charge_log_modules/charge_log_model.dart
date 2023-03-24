class ChargeLogModel {
  int? code;
  String? message;
  Data? data;

  ChargeLogModel({this.code, this.message, this.data});

  ChargeLogModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ChargeLogList>? list;
  int? totalPage;

  Data({this.list, this.totalPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ChargeLogList>[];
      json['list'].forEach((v) {
        list!.add(ChargeLogList.fromJson(v));
      });
    }
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    data['total_page'] = totalPage;
    return data;
  }
}

class ChargeLogList {
  int? id;
  String? orderNo;
  String? gold;
  String? amount;
  int? payStatus;
  var payTime;
  String? updatedAt;
  var createdAt;
  String? image;

  ChargeLogList(
      {this.id,
        this.orderNo,
        this.gold,
        this.amount,
        this.payStatus,
        this.payTime,
        this.updatedAt,
        this.createdAt,
        this.image});

  ChargeLogList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    gold = json['gold'];
    amount = json['amount'];
    payStatus = json['pay_status'];
    payTime = json['pay_time'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_no'] = this.orderNo;
    data['gold'] = this.gold;
    data['amount'] = this.amount;
    data['pay_status'] = this.payStatus;
    data['pay_time'] = this.payTime;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}
