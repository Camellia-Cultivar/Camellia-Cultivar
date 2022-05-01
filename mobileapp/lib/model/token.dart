import 'dart:convert';

class Token {
  int? expiresIn;

  // Token();

  Token.parse(String json) {
    Map<String, dynamic> map = jsonDecode(json);

    expiresIn = map["expiresIn"];
  }

  @override
  String toString() {
    return jsonEncode({"expiresIn": expiresIn});
  }
}
