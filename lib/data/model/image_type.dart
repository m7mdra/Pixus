enum ImageType { all, photo, illustration, vector }

extension ImageTypeExtension on ImageType {
  String get name {
    switch (this) {
      case ImageType.all:
        return "All";
      case ImageType.illustration:
        return "Illustration";
      case ImageType.photo:
        return "Photo";

      case ImageType.vector:
        return "Vector";
    }
  }
}
