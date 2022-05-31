import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  //String password;
  int reputation;
  String profileImageUrl;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      //required this.password,
      required this.reputation,
      required this.profileImageUrl});

  String get name {
    return firstName + " " + lastName;
  }

  @override
  String toString() {
    return 'id: $id, firstName: $firstName, lastName: $lastName, email: $email repuation: $reputation, profileImage: $profileImageUrl';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      //'password': password,
      "reputation": reputation,
      "profileImage": profileImageUrl
    };
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      //password: json["password"],
      profileImageUrl: json["profile_photo"],
      reputation: json["reputation"]);
}
