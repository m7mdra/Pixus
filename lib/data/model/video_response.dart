class VideosResponse {
  int? total;
  int? totalHits;
  List<Video> list = [];

  VideosResponse.fromJson(dynamic json) {
    total = json["total"];
    totalHits = json["totalHits"];
    if (json["hits"] != null) {
      list = [];
      json["hits"].forEach((v) {
        list.add(Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["total"] = total;
    map["totalHits"] = totalHits;
    map["hits"] = list.map((v) => v.toJson()).toList();
    return map;
  }
}

class Video {
  int? id;
  String? pageURL;
  String? type;
  String? tags;
  int? duration;
  late String pictureId;
  late Urls? urls;
  int? views;
  int? downloads;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageURL;

  Video.fromJson(dynamic json) {
    id = json["id"];
    pageURL = json["pageURL"];
    type = json["type"];
    tags = json["tags"];
    duration = json["duration"];
    pictureId = json["picture_id"];
    urls = json["videos"] != null ? Urls.fromJson(json["videos"]) : null;
    views = json["views"];
    downloads = json["downloads"];
    likes = json["likes"];
    comments = json["comments"];
    userId = json["user_id"];
    user = json["user"];
    userImageURL = json["userImageURL"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["pageURL"] = pageURL;
    map["type"] = type;
    map["tags"] = tags;
    map["duration"] = duration;
    map["picture_id"] = pictureId;

    map["views"] = views;
    map["downloads"] = downloads;
    map["likes"] = likes;
    map["comments"] = comments;
    map["user_id"] = userId;
    map["user"] = user;
    map["userImageURL"] = userImageURL;
    return map;
  }
}

class Urls {
  late Media? large;
  late Media? medium;
  late Media? small;
  late Media? tiny;

  Urls.fromJson(dynamic json) {
    large = json["large"] != null ? Media.fromJson(json["large"]) : null;
    medium = json["medium"] != null ? Media.fromJson(json["medium"]) : null;
    small = json["small"] != null ? Media.fromJson(json["small"]) : null;
    tiny = json["tiny"] != null ? Media.fromJson(json["tiny"]) : null;
  }


}

class Media {
 late String url;
 late int width;
 late int height;
 late int size;

 Media.fromJson(dynamic json) {
    url = json["url"];
    width = json["width"];
    height = json["height"];
    size = json["size"];
  }


}

