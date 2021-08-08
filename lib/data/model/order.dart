enum Order { popular, latest }

extension OrderExtension on Order {
  String get name {
    switch (this) {
      case Order.popular:
        return "popular";
        break;
      case Order.latest:
        return "latest";
    }
  }
}
