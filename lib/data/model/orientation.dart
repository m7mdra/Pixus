enum Orientation { all, horizontal, vertical }

extension OrientationExtensions on Orientation {
  String get name {
    switch (this) {
      case Orientation.all:
        return "All";
      case Orientation.horizontal:
        return "Horizontal";
      case Orientation.vertical:
        return "Vertical";
    }
  }
}
