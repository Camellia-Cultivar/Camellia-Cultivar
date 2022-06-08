import 'package:camellia_cultivar/model/upov_category.dart';
import 'dart:convert';

class ListCategory {
  List<UpovCategory> cats;

  ListCategory({required this.cats});

  @override
  String toString() {
    return 'cats: $cats';
  }

  Map<String, dynamic> toJson() {
    return {'cats': cats};
  }

  factory ListCategory.fromJson(dynamic json) {
    var catObjsJson = json as List;
    print("the objects " + catObjsJson.length.toString());
    for (int i = 0; i < 17; i++) {
      print(i);
      print(catObjsJson.runtimeType);
      print(json.runtimeType);
      print(Map.from(catObjsJson[i]));
      var upov = UpovCategory.fromJson(Map.from(catObjsJson[i]));
      // print(upov);
    }
    // List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
    List<UpovCategory> _cats =
        catObjsJson.map((optJson) => UpovCategory.fromJson(optJson)).toList();
    print(_cats);
    return ListCategory(cats: _cats);
  }
}
