class Vehicle {
  String? company;
  String? number;
  String? color;
  String? regDate;
  String? picture;
  String? model;
  String? regUnder;

  Vehicle(String company, String number, String color, String regDate,
      String regUnder, String picture,String model) {
    this.company = company;
    this.number = number;
    this.color = color;
    this.regDate = regDate;
    this.regUnder = regUnder;
    this.picture = picture;
    this.model = model;
  }
}
