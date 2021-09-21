class UserModel {
  String name;
  String dob;
  String phone;
  String age;
  String gender;
  String address;
  String lon;
  String lat;

  UserModel({
    this.address,
    this.age,
    this.dob,
    this.gender,
    this.lat,
    this.lon,
    this.name,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        address: json['address'],
        name: json['name'],
        dob: json['dob'],
        gender: json['gender'],
        phone: json['phone']);
  }
}
