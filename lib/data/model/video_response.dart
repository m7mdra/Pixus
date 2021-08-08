class VideoResponse {
  int? total;
  int? totalHits;
  List<Video>? list;

  VideoResponse({
      this.total, 
      this.totalHits, 
      this.list});

  VideoResponse.fromJson(dynamic json) {
    total = json["total"];
    totalHits = json["totalHits"];
    if (json["hits"] != null) {
      list = [];
      json["hits"].forEach((v) {
        list?.add(Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["total"] = total;
    map["totalHits"] = totalHits;
    if (list != null) {
      map["hits"] = list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Video {
  int? id;
  String? pageURL;
  String? type;
  String? tags;
  int? duration;
  String? pictureId;
  Urls? urls;
  int? views;
  int? downloads;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageURL;

  Video({
      this.id, 
      this.pageURL, 
      this.type, 
      this.tags, 
      this.duration, 
      this.pictureId, 
      this.urls,
      this.views, 
      this.downloads, 
      this.likes, 
      this.comments, 
      this.userId, 
      this.user, 
      this.userImageURL});

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
    if (urls != null) {
      map["videos"] = urls?.toJson();
    }
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
  Large? large;
  Medium? medium;
  Small? small;
  Tiny? tiny;

  Urls({
      this.large, 
      this.medium, 
      this.small, 
      this.tiny});

  Urls.fromJson(dynamic json) {
    large = json["large"] != null ? Large.fromJson(json["large"]) : null;
    medium = json["medium"] != null ? Medium.fromJson(json["medium"]) : null;
    small = json["small"] != null ? Small.fromJson(json["small"]) : null;
    tiny = json["tiny"] != null ? Tiny.fromJson(json["tiny"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (large != null) {
      map["large"] = large?.toJson();
    }
    if (medium != null) {
      map["medium"] = medium?.toJson();
    }
    if (small != null) {
      map["small"] = small?.toJson();
    }
    if (tiny != null) {
      map["tiny"] = tiny?.toJson();
    }
    return map;
  }

}

class Tiny {
  String? url;
  int? width;
  int? height;
  int? size;

  Tiny({
      this.url, 
      this.width, 
      this.height, 
      this.size});

  Tiny.fromJson(dynamic json) {
    url = json["url"];
    width = json["width"];
    height = json["height"];
    size = json["size"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["width"] = width;
    map["height"] = height;
    map["size"] = size;
    return map;
  }

}

class Small {
  String? url;
  int? width;
  int? height;
  int? size;

  Small({
      this.url, 
      this.width, 
      this.height, 
      this.size});

  Small.fromJson(dynamic json) {
    url = json["url"];
    width = json["width"];
    height = json["height"];
    size = json["size"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["width"] = width;
    map["height"] = height;
    map["size"] = size;
    return map;
  }

}

class Medium {
  String? url;
  int? width;
  int? height;
  int? size;

  Medium({
      this.url, 
      this.width, 
      this.height, 
      this.size});

  Medium.fromJson(dynamic json) {
    url = json["url"];
    width = json["width"];
    height = json["height"];
    size = json["size"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["width"] = width;
    map["height"] = height;
    map["size"] = size;
    return map;
  }

}

class Large {
  String? url;
  int? width;
  int? height;
  int? size;

  Large({
      this.url, 
      this.width, 
      this.height, 
      this.size});

  Large.fromJson(dynamic json) {
    url = json["url"];
    width = json["width"];
    height = json["height"];
    size = json["size"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["width"] = width;
    map["height"] = height;
    map["size"] = size;
    return map;
  }

}