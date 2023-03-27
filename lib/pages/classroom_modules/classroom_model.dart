class ClassRoomModel {
  int? code;
  String? message;
  Data? data;

  ClassRoomModel({this.code, this.message, this.data});

  ClassRoomModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<ClassRoomList>? list;
  int? totalPage;

  Data({this.list, this.totalPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ClassRoomList>[];
      json['list'].forEach((v) {
        list!.add(ClassRoomList.fromJson(v));
      });
    }
    totalPage = json['total_page'];
  }

}

class ClassRoomList {
  int? courseTimeId;
  int? courseId;
  String? name;
  String? teacherName;
  int? totalUser;
  String? address;
  String? startDay;
  String? startTime;
  String? endTime;
  int? subscribeId;
  int? subscribeStatus;
  int? subscribeUser;
  int? signIn;
  String? teacherAvatar;

  ClassRoomList(
      {this.courseTimeId,
        this.courseId,
        this.name,
        this.teacherName,
        this.totalUser,
        this.address,
        this.startDay,
        this.startTime,
        this.endTime,
        this.subscribeId,
        this.subscribeStatus,
        this.signIn,
        this.teacherAvatar,
        this.subscribeUser});

  ClassRoomList.fromJson(Map<String, dynamic> json) {
    courseTimeId = json['course_time_id'];
    courseId = json['course_id'];
    name = json['name'];
    teacherName = json['teacher_name'];
    totalUser = json['total_user'];
    address = json['address'];
    startDay = json['start_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    subscribeId = json['subscribe_id'];
    subscribeStatus = json['subscribe_status'];
    subscribeUser = json['subscribe_user'];
    teacherAvatar = json['teacher_avatar'];
    signIn = json['sign_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_time_id'] = this.courseTimeId;
    data['course_id'] = this.courseId;
    data['name'] = this.name;
    data['teacher_name'] = this.teacherName;
    data['total_user'] = this.totalUser;
    data['address'] = this.address;
    data['start_day'] = this.startDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['subscribe_id'] = this.subscribeId;
    data['subscribe_status'] = this.subscribeStatus;
    data['subscribe_user'] = this.subscribeUser;
    return data;
  }
}
