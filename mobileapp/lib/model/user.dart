import 'dart:convert';

User userFromJson(String str, int id) => User.fromJson(json.decode(str), id);

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  double reputation;
  String profileImage;
  bool verified;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.reputation,
      required this.profileImage,
      required this.verified});

  String get name {
    return firstName + " " + lastName;
  }

  set getProfileImage(String url) {
    profileImage = url;
  }

  @override
  String toString() {
    return 'id: $id, firstName: $firstName, lastName: $lastName, email: $email reputation: $reputation, profileImage: $profileImage, verified: $verified';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      "reputation": reputation,
      "profile_image": profileImage,
      "verified": verified,
    };
  }

  // Map<String, dynamic> toJsonRegister() {
  //   return {
  //     'first_name': firstName,
  //     'last_name': lastName,
  //     'email': email,
  //     'password': password,
  //   };
  // }

  // Map<String, dynamic> toJsonLogin() {
  //   return {
  //     'email': email,
  //     'password': password,
  //   };
  // }

  factory User.fromJson(Map<String, dynamic> json, int id) {
    // print("AAAAAAAAAAHHHHHHHHHHH" + json.toString() + "\n" + id.toString());
    print(json["first_name"].runtimeType);
    print((json["last_name"] as String).runtimeType);
    print(json["email"].runtimeType);
    print(json["reputation"].runtimeType);
    print(json["profile_image"].runtimeType);
    print(json["verified"].runtimeType);
    print(id.runtimeType);
    var user = User(
        id: id,
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        profileImage: json["profile_image"],
        reputation: json["reputation"],
        verified: json["verified"]);
    print("AAAAAAAAAAHHHHHHHHHHH" + user.toString());
    return user;
  }
}
