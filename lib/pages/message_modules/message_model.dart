class MessageModel {
  int? code;
  String? message;
  Data? data;

  MessageModel({this.code, this.message, this.data});

  MessageModel.fromJson(Map<String, dynamic> json) {
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
  List<MessageList>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <MessageList>[];
      json['list'].forEach((v) {
        list!.add(MessageList.fromJson(v));
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

class MessageList {
  int? id;
  String? name;
  int? userId;
  String? msg;
  String? createdAt;
  String? coursesName;
  String? teacherName;
  String? startDay;
  int? noticeType;

  MessageList(
      {this.id,
        this.name,
        this.userId,
        this.msg,
        this.createdAt,
        this.coursesName,
        this.teacherName,
        this.noticeType,
        this.startDay});

  MessageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    msg = json['msg'];
    createdAt = json['created_at'];
    coursesName = json['courses_name'];
    teacherName = json['teacher_name'];
    startDay = json['start_day'];
    noticeType = json['notice_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['msg'] = this.msg;
    data['created_at'] = this.createdAt;
    data['courses_name'] = this.coursesName;
    data['teacher_name'] = this.teacherName;
    data['start_day'] = this.startDay;
    return data;
  }
}
