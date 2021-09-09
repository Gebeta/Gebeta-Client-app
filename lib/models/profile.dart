class Profile {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNo;
  String address;
  String password;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.password,
  });
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phoneNo: json["phone_no"],
      address: json["address"],
      password: json["password"],
    );
  }
}
