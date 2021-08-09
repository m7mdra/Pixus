enum Category{
  backgrounds, fashion, nature, science, education, feelings, health, people, religion, places, animals, industry, computer, food, sports, transportation, travel, buildings, business, music
}
extension CategoryExtensions on Category{
  String get name{
    switch(this){
      case Category.backgrounds:
        return "Backgrounds";
      case Category.fashion:
        return "Fashion";
      case Category.nature:
        return "Nature";
      case Category.science:
        return "Science";
      case Category.education:
        return "Education";
      case Category.feelings:
        return "Feelings";
      case Category.health:
        return "Health";
      case Category.people:
        return "People";
      case Category.religion:
        return "Religion";
      case Category.places:
        return "Places";
      case Category.animals:
        return "Animals";
      case Category.industry:
        return "Industry";
      case Category.computer:
        return "Computer";
      case Category.food:
        return "Food";
      case Category.sports:
        return "Sports";
      case Category.transportation:
        return "Transportation";
      case Category.travel:
        return "Travel";
      case Category.buildings:
        return "Buildings";
      case Category.business:
        return "Business";
      case Category.music:
        return "Music";
    }
  }
}