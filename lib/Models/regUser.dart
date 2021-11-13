class RegUserModel {
  String detail;

  RegUserModel({
    this.detail,
  });

  factory RegUserModel.fromJson(Map<String, dynamic> json) {
    return RegUserModel(detail: json['Details']);
  }
}
