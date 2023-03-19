class SharedWalletLogModel {
  int? code;
  String? message;
  Data? data;

  SharedWalletLogModel({this.code, this.message, this.data});

  SharedWalletLogModel.fromJson(Map<String, dynamic> json) {
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
  List<SharedWalletLogList>? list;
  int? totalPage;

  Data({this.list, this.totalPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SharedWalletLogList>[];
      json['list'].forEach((v) {
        list!.add( SharedWalletLogList.fromJson(v));
      });
    }
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['total_page'] = this.totalPage;
    return data;
  }
}

class SharedWalletLogList {
  int? id;
  int? userId;
  String? name;
  int? type;
  String? amount;
  String? beforeAmount;
  String? afterAmount;
  String? createdAt;

  SharedWalletLogList(
      {this.id,
        this.userId,
        this.name,
        this.type,
        this.amount,
        this.beforeAmount,
        this.afterAmount,
        this.createdAt});

  SharedWalletLogList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    type = json['type'];
    amount = json['amount'];
    beforeAmount = json['before_amount'];
    afterAmount = json['after_amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['before_amount'] = this.beforeAmount;
    data['after_amount'] = this.afterAmount;
    data['created_at'] = this.createdAt;
    return data;
  }
}
