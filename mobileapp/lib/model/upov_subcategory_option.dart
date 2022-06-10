import 'dart:convert';

UpovSubcategoryOption optionFromJson(String str) =>
    UpovSubcategoryOption.fromJson(json.decode(str));

class UpovSubcategoryOption {
  int value;
  String descriptor;
  int id;

  UpovSubcategoryOption(
      {required this.value, required this.descriptor, required this.id});

  @override
  String toString() {
    return 'id: $id, descriptor: $descriptor, value: $value';
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'descriptor': descriptor,
      'id': id,
    };
  }

  factory UpovSubcategoryOption.fromJson(Map<String, dynamic> json) {
    return UpovSubcategoryOption(
        id: json["id"], descriptor: json["descriptor"], value: json["value"]);
  }
}
