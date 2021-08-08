enum Order { popular, latest }

extension OrderExtension on Order {
  String get name {
    switch (this) {
      case Order.popular:
        return "popular";
      case Order.latest:
        return "latest";
    }
  }
}
