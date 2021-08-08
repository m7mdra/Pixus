enum ImageType { all, photo, illustration, vector }

extension ImageTypeExtension on ImageType {
  String get name {
    switch (this) {
      case ImageType.all:
        return "all";
      case ImageType.illustration:
        return "illustration";
      case ImageType.photo:
        return "photo";

      case ImageType.vector:
        return "vector";
    }
  }
}
