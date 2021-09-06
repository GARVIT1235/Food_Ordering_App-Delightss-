class UserModel {
  String name;
  String dob;
  String phone;
  String age;
  String gender;
  String address;
  String lon;
  String lat;

  UserModel(
      {
        this.address,
        this.age,
        this.dob,
        this.gender,
        this.lat,
        this.lon,
        this.name,
        this.phone
      }
      );
}