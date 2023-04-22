class CourseCateModel {
  int? code;
  String? message;
  Data? data;

  CourseCateModel({this.code, this.message, this.data});

  CourseCateModel.fromJson(Map<String, dynamic> json) {
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
  List<CourseCateList>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CourseCateList>[];
      json['list'].forEach((v) {
        list!.add(new CourseCateList.fromJson(v));
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

class CourseCateList {
  int? cateId;
  String? cateName;

  CourseCateList({this.cateId, this.cateName});

  CourseCateList.fromJson(Map<String, dynamic> json) {
    cateId = json['cate_id'];
    cateName = json['cate_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cate_id'] = this.cateId;
    data['cate_name'] = this.cateName;
    return data;
  }
}
