class SharedWalletModel {
  int? code;
  String? message;
  var data;

  SharedWalletModel({this.code, this.message, this.data});

  SharedWalletModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  dynamic owner;
  List<UserList>? userList;

  Data({this.owner, this.userList});

  Data.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    if (json['user_list'] != null) {
      userList = <UserList>[];
      json['user_list'].forEach((v) {
        userList!.add(new UserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.userList != null) {
      data['user_list'] = this.userList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  int? id;
  String? name;
  var avatar;
  var balance;
  var walletExpireAt;

  Owner({this.id, this.name, this.avatar, this.balance, this.walletExpireAt});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    balance = json['balance'];
    walletExpireAt = json['wallet_expire_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['balance'] = this.balance;
    data['wallet_expire_at'] = this.walletExpireAt;
    return data;
  }
}

class UserList {
  int? id;
  String? name;
  String? avatar;

  UserList({this.id, this.name, this.avatar});

  UserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}
