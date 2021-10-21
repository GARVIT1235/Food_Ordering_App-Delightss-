class BestCategory {
  String name;
  String rating;
  String imgPath;
  String price;
  String isVeg;

  BestCategory({this.name, this.rating, this.imgPath, this.price, this.isVeg});

  factory BestCategory.fromJson(Map<String, dynamic> json) {
    return BestCategory(
        name: json['Name'],
        rating: json['Rating'],
        imgPath: json['image'],
        price: json['Price'],
        isVeg: json['IsVeg']);
  }
}
