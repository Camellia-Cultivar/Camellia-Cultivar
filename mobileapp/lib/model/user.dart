import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  //String password;
  int reputation;
  String? profileImage;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      //required this.password,
      required this.reputation,
      this.profileImage});

  String get name {
    return firstName + " " + lastName;
  }

  @override
  String toString() {
    return 'id: $id, firstName: $firstName, lastName: $lastName, email: $email repuation: $reputation, profileImage: $profileImage';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      //'password': password,
      "reputation": reputation,
      "profileImage": profileImage
    };
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      //password: json["password"],
      profileImage: json["profile_image"],
      reputation: json["reputation"]);
}
