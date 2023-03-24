class TeacherListModel {
  int? code;
  String? message;
  Data? data;

  TeacherListModel({this.code, this.message, this.data});

  TeacherListModel.fromJson(Map<String, dynamic> json) {
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
  List<TeacherList>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <TeacherList>[];
      json['list'].forEach((v) {
        list!.add(new TeacherList.fromJson(v));
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

class TeacherList {
  int? teacherId;
  String? teacherName;

  TeacherList({this.teacherId, this.teacherName});

  TeacherList.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacher_id'];
    teacherName = json['teacher_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacher_id'] = this.teacherId;
    data['teacher_name'] = this.teacherName;
    return data;
  }
}
