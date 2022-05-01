class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String password;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
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
