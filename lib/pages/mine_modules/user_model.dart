class UserModel {
  int? code;
  String? message;
  Data? data;

  UserModel({this.code, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? phone;
  String? balance;
  String? birth;
  String? optional;
  String? updatedAt;
  String? createdAt;
  var avatar;
  var walletExpireAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.balance,
        this.birth,
        this.optional,
        this.updatedAt,
        this.avatar,
        this.walletExpireAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    balance = json['balance'];
    birth = json['birth'];
    optional = json['optional'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    avatar = json['avatar'];
    walletExpireAt = json['wallet_expire_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['balance'] = this.balance;
    data['birth'] = this.birth;
    data['optional'] = this.optional;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
