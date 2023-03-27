class HomeIndexModel {
  int? code;
  String? message;
  Data? data;

  HomeIndexModel({this.code, this.message, this.data});

  HomeIndexModel.fromJson(Map<String, dynamic> json) {
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
  List<Banner>? banner;
  List<Notice>? notice;
  Site? site;

  Data({this.banner, this.notice, this.site});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banner'] != null) {
      banner = <Banner>[];
      json['banner'].forEach((v) {
        banner!.add(new Banner.fromJson(v));
      });
    }
    if (json['notice'] != null) {
      notice = <Notice>[];
      json['notice'].forEach((v) {
        notice!.add(new Notice.fromJson(v));
      });
    }
    site = json['site'] != null ? new Site.fromJson(json['site']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    if (this.notice != null) {
      data['notice'] = this.notice!.map((v) => v.toJson()).toList();
    }
    if (this.site != null) {
      data['site'] = this.site!.toJson();
    }
    return data;
  }
}

class Banner {
  int? id;
  String? name;
  String? coverUrl;
  String? url;

  Banner({this.id, this.name, this.coverUrl, this.url});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverUrl = json['cover_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover_url'] = this.coverUrl;
    data['url'] = this.url;
    return data;
  }
}

class Notice {
  int? id;
  String? title;
  String? picUrl;
  String? body;
  String? noticeTime;

  Notice({this.id, this.title, this.picUrl, this.body,this.noticeTime});

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    picUrl = json['pic_url'];
    body = json['body'];
    noticeTime = json['notice_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['pic_url'] = this.picUrl;
    data['body'] = this.body;
    return data;
  }
}

class Site {
  String? address;
  String? mail;
  String? tel;

  Site({this.address, this.mail, this.tel});

  Site.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    mail = json['mail'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['mail'] = this.mail;
    data['tel'] = this.tel;
    return data;
  }
}
