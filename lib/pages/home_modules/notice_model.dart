class NoticeModel {
  int? code;
  String? message;
  Data? data;

  NoticeModel({this.code, this.message, this.data});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<NoticeList>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <NoticeList>[];
      json['list'].forEach((v) {
        list!.add( NoticeList.fromJson(v));
      });
    }
  }

}

class NoticeList {
  int? id;
  String? title;
  var picUrl;

  NoticeList({this.id, this.title, this.picUrl});

  NoticeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    picUrl = json['pic_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['pic_url'] = this.picUrl;
    return data;
  }
}
