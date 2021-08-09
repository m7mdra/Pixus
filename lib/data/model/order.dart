enum Order { popular, latest }

extension OrderExtension on Order {
  String get name {
    switch (this) {
      case Order.popular:
        return "Popular";
      case Order.latest:
        return "Latest";
    }
  }
}
