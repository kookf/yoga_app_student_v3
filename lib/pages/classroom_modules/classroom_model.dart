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
  List<Classroomlist>? classroomlist;
  int? totalPage;

  Data({this.classroomlist, this.totalPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      classroomlist = <Classroomlist>[];
      json['list'].forEach((v) {
        classroomlist!.add(Classroomlist.fromJson(v));
      });
    }
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.classroomlist != null) {
      data['list'] = this.classroomlist!.map((v) => v.toJson()).toList();
    }
    data['total_page'] = this.totalPage;
    return data;
  }
}

class Classroomlist {
  String? day;
  List<Course>? course;

  Classroomlist({this.day, this.course});

  Classroomlist.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['course'] != null) {
      course = <Course>[];
      json['course'].forEach((v) {
        course!.add(Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.course != null) {
      data['course'] = this.course!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  int? courseTimeId;
  int? teacherId;
  int? courseId;
  String? name;
  var gold;
  int? times;
  String? teacherName;
  String? teacherAvatar;
  int? totalUser;
  var address;
  String? startDay;
  String? startTime;
  String? endTime;
  int? subscribeId;
  int? subscribeStatus;
  var cause;
  int? subscribeUser;
  int? signIn;

  Course(
      {this.courseTimeId,
      this.teacherId,
      this.courseId,
      this.name,
      this.gold,
      this.times,
      this.teacherName,
      this.teacherAvatar,
      this.totalUser,
      this.address,
      this.startDay,
      this.startTime,
      this.endTime,
      this.subscribeId,
      this.subscribeStatus,
      this.cause,
      this.subscribeUser,
      this.signIn});

  Course.fromJson(Map<String, dynamic> json) {
    courseTimeId = json['course_time_id'];
    teacherId = json['teacher_id'];
    courseId = json['course_id'];
    name = json['name'];
    gold = json['gold'];
    times = json['times'];
    teacherName = json['teacher_name'];
    teacherAvatar = json['teacher_avatar'];
    totalUser = json['total_user'];
    address = json['address'];
    startDay = json['start_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    subscribeId = json['subscribe_id'];
    subscribeStatus = json['subscribe_status'];
    cause = json['cause'];
    subscribeUser = json['subscribe_user'];
    signIn = json['sign_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_time_id'] = this.courseTimeId;
    data['teacher_id'] = this.teacherId;
    data['course_id'] = this.courseId;
    data['name'] = this.name;
    data['gold'] = this.gold;
    data['times'] = this.times;
    data['teacher_name'] = this.teacherName;
    data['teacher_avatar'] = this.teacherAvatar;
    data['total_user'] = this.totalUser;
    data['address'] = this.address;
    data['start_day'] = this.startDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['subscribe_id'] = this.subscribeId;
    data['subscribe_status'] = this.subscribeStatus;
    data['cause'] = this.cause;
    data['subscribe_user'] = this.subscribeUser;
    data['sign_in'] = this.signIn;
    return data;
  }
}
