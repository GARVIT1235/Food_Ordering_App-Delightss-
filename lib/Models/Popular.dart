class PopularCategory {
  String name;
  String rating;
  String imgPath;
  int price;
  String isVeg;
  int amount = 1;

  PopularCategory(
      {this.name, this.rating, this.imgPath, this.price, this.isVeg});

  factory PopularCategory.fromJson(Map<String, dynamic> json) {
    return PopularCategory(
        name: json['Name'],
        rating: json['Rating'],
        imgPath: json['image'],
        price: json['Price'],
        isVeg: json['IsVeg']);
  }
}
