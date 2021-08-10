enum VideoType { all, film, animation }

extension VideoTypeExtension on VideoType {
  String get name {
    switch (this) {
      case VideoType.all:
        return "All";
      case VideoType.film:
        return "Film";
      case VideoType.animation:
        return "Animation";
    }
  }
}
