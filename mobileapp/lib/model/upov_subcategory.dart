import 'dart:convert';

import 'package:camellia_cultivar/model/upov_subcategory_option.dart';

UpovSubcategory optionFromJson(String str) =>
    UpovSubcategory.fromJson(json.decode(str));

class UpovSubcategory {
  List<UpovSubcategoryOption>? options;
  String name;
  int id;

  UpovSubcategory(
      {required this.options, required this.name, required this.id});

  @override
  String toString() {
    return 'id: $id, name: $name, options: $options';
  }

  Map<String, dynamic> toJson() {
    return {
      'value': options,
      'name': name,
      'id': id,
    };
  }

  factory UpovSubcategory.fromJson(Map<String, dynamic> json) {
    // print(json);
    var charObjsJson = json["options"] as List;
    if (charObjsJson == null) {
      return UpovSubcategory(options: [], name: json["name"], id: json["id"]);
    }

    // print(charObjsJson);
    List<UpovSubcategoryOption> _options = charObjsJson
        .map((optJson) => UpovSubcategoryOption.fromJson(optJson))
        .toList();
    return UpovSubcategory(
        options: _options, name: json["name"], id: json["id"]);
  }
}
