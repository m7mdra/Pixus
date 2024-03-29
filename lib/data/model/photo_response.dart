class PhotoResponse {
  int? total;
  int? totalHits;
  List<Photo> list = [];

  PhotoResponse({this.total, this.totalHits, this.list = const []});

  PhotoResponse.fromJson(dynamic json) {
    total = json["total"];
    totalHits = json["totalHits"];
    if (json["hits"] != null) {
      list = [];
      json["hits"].forEach((v) {
        list.add(Photo.fromJson(v));
      });
    }
  }


}

class Photo {
  late int id;
  late String pageURL;
  late String type;
  late String tags;
  late String previewURL;
  late int previewWidth;
  late int previewHeight;
  late String webformatURL;
  late int webformatWidth;
  late int webformatHeight;
  late String largeImageURL;
  late int imageWidth;
  late int imageHeight;
  int? imageSize;
  int? views;
  int? downloads;
  int? collections;
  int? likes;
  int? comments;
  int? userId;
  late String user;
  late String userImageURL;



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
