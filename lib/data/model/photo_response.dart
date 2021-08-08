class PhotoResponse {
  int? total;
  int? totalHits;
  List<Photo>? list;

  PhotoResponse({
      this.total, 
      this.totalHits, 
      this.list});

  PhotoResponse.fromJson(dynamic json) {
    total = json["total"];
    totalHits = json["totalHits"];
    if (json["hits"] != null) {
      list = [];
      json["hits"].forEach((v) {
        list?.add(Photo.fromJson(v));
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

class Photo {
  int? id;
  String? pageURL;
  String? type;
  String? tags;
  String? previewURL;
  int? previewWidth;
  int? previewHeight;
  String? webformatURL;
  int? webformatWidth;
  int? webformatHeight;
  String? largeImageURL;
  int? imageWidth;
  int? imageHeight;
  int? imageSize;
  int? views;
  int? downloads;
  int? collections;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageURL;

  Photo({
      this.id, 
      this.pageURL, 
      this.type, 
      this.tags, 
      this.previewURL, 
      this.previewWidth, 
      this.previewHeight, 
      this.webformatURL, 
      this.webformatWidth, 
      this.webformatHeight, 
      this.largeImageURL, 
      this.imageWidth, 
      this.imageHeight, 
      this.imageSize, 
      this.views, 
      this.downloads, 
      this.collections, 
      this.likes, 
      this.comments, 
      this.userId, 
      this.user, 
      this.userImageURL});

  Photo.fromJson(dynamic json) {
    id = json["id"];
    pageURL = json["pageURL"];
    type = json["type"];
    tags = json["tags"];
    previewURL = json["previewURL"];
    previewWidth = json["previewWidth"];
    previewHeight = json["previewHeight"];
    webformatURL = json["webformatURL"];
    webformatWidth = json["webformatWidth"];
    webformatHeight = json["webformatHeight"];
    largeImageURL = json["largeImageURL"];
    imageWidth = json["imageWidth"];
    imageHeight = json["imageHeight"];
    imageSize = json["imageSize"];
    views = json["views"];
    downloads = json["downloads"];
    collections = json["collections"];
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
    map["previewURL"] = previewURL;
    map["previewWidth"] = previewWidth;
    map["previewHeight"] = previewHeight;
    map["webformatURL"] = webformatURL;
    map["webformatWidth"] = webformatWidth;
    map["webformatHeight"] = webformatHeight;
    map["largeImageURL"] = largeImageURL;
    map["imageWidth"] = imageWidth;
    map["imageHeight"] = imageHeight;
    map["imageSize"] = imageSize;
    map["views"] = views;
    map["downloads"] = downloads;
    map["collections"] = collections;
    map["likes"] = likes;
    map["comments"] = comments;
    map["user_id"] = userId;
    map["user"] = user;
    map["userImageURL"] = userImageURL;
    return map;
  }

}