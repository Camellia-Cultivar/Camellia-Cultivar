class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String password;
  int reputation;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.reputation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      "reputation": reputation,
    };
  }

  String get name {
    return firstName + " " + lastName;
  }

  @override
  String toString() {
    return 'id: $id, firstName: $firstName, lastName: $lastName, email: $email, password: $password';
  }
}
