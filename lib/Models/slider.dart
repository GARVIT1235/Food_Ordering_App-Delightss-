class SliderCategory {
  String imgPath;

  SliderCategory({
    this.imgPath,
  });

  factory SliderCategory.fromJson(Map<String, dynamic> json) {
    return SliderCategory(imgPath: json['imgPath']);
  }
}
