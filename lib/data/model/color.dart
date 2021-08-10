enum C {
  all,
  grayscale,
  transparent,
  red,
  orange,
  yellow,
  green,
  turquoise,
  blue,
  lilac,
  pink,
  white,
  gray,
  black,
  brown
}

extension ColorExtensions on C {
  String get name{
    switch(this){
      case C.all:
        return "All";
      case C.grayscale:
        return "Grayscale";
      case C.transparent:
        return "Transparent";

      case C.red:
        return "Red";

      case C.orange:
        return "Orange";

      case C.yellow:
        return "Yellow";

      case C.green:
        return "Green";
      case C.turquoise:
        return "Turquoise";
      case C.blue:
        return "Blue";
      case C.lilac:
        return "Lilac";
      case C.pink:
        return "Pink";
      case C.white:
        return "White";
      case C.gray:
        return "Gray";
      case C.black:
        return "Black";
      case C.brown:
        return "Brown";
    }
  }
}
