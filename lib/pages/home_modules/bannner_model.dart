class BannerModel {
  int? code;
  String? message;
  Data? data;

  BannerModel({this.code, this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<BannerList>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <BannerList>[];
      json['list'].forEach((v) {
        list!.add(new BannerList.fromJson(v));
      });
    }
  }


}

class BannerList {
  int? id;
  String? name;
  String? coverUrl;
  String? url;

  BannerList({this.id, this.name, this.coverUrl, this.url});

  BannerList.fromJson(Map<String, dynamic> json) {
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
