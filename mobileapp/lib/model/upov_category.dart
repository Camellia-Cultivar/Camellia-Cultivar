import 'dart:convert';

import 'package:camellia_cultivar/model/upov_subcategory.dart';

UpovCategory optionFromJson(String str) =>
    UpovCategory.fromJson(json.decode(str));

class UpovCategory {
  List<UpovSubcategory> characteristics;
  String category;
  String id;

  UpovCategory(
      {required this.characteristics,
      required this.category,
      required this.id});

  String get getCategory {
    return category;
  }

  @override
  String toString() {
    return 'id: $id, category: $category, characteristics: $characteristics';
  }

  Map<String, dynamic> toJson() {
    return {
      'characteristics': characteristics,
      'category': category,
      'id': id,
    };
  }

  factory UpovCategory.fromJson(Map<String, dynamic> json) {
    var charObjsJson = json["characteristics"] as List;
    List<UpovSubcategory> _subcategories = charObjsJson
        .map((subcatJson) => UpovSubcategory.fromJson(subcatJson))
        .toList();
    print(json);
    return UpovCategory(
        characteristics: _subcategories,
        category: json["category"],
        id: json["id"]);
  }
}
