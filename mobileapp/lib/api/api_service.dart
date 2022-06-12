import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:camellia_cultivar/model/coordinates.dart';
import 'package:camellia_cultivar/model/question.dart';
import 'package:camellia_cultivar/model/uploaded_specimen.dart';
import 'package:camellia_cultivar/model/upov_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

import '../quizzes/quiz_page.dart';
import 'api_constants.dart';
import '../model/user.dart';

Map<int, User> mockUser = {
  0: User(
      id: 0,
      firstName: "John",
      lastName: "Doe",
      email: "jd@ua.pt",
      reputation: 0,
      profileImage: "https://i.imgflip.com/2/1975nj.jpg",
      verified: true)
};

Map<int, String> mockPassord = {0: "12345"};

class APIService {
  final storage = FlutterSecureStorage();

  Future<List<Object>> login(Map login_user) async {
    var er;
    try {
      var url = Uri.parse(APIConstants.baseUrl + APIConstants.loginEndpoint);

      var body = jsonEncode(login_user);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*"
          },
          body: body);
      if (response.statusCode == 200 && response.body == "") {
        return [-2, "Credentials are wrong!"];
      }
      return [response.statusCode, response.body];
    } catch (e) {
      log(e.toString());
      er = e;
    }
    return [-1, "Failed to authenticate. Please try again!"];
  }

  Future<User?> getUser(int uid) async {
    try {
      var url = Uri.parse(
          APIConstants.baseUrl + APIConstants.profileEndpoint + "/${uid}");
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer ${await storage.read(key: 'token')}',
      });
      print(response.body);
      print(await storage.read(key: 'token'));
      if (response.statusCode == 202) {
        User api_user = userFromJson(response.body, uid);
        // api_user.profileImage = "\x00";
        return api_user;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Object>> createUser(Map signup_user) async {
    try {
      var url = Uri.parse(APIConstants.baseUrl + APIConstants.registerEndpoint);
      var body = jsonEncode(signup_user);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*",
          },
          body: body);
      return [response.statusCode, response.body];
    } catch (e) {
      log(e.toString());
      log("Could not fetch from api");
      // throw e;
    }
    return [-1, "Failed to create account. Please try again later!"];
  }

  //TODO: Use try-catch when using this function
  Future<void> updateUser(User user, String password) async {
    try {
      var url = Uri.parse(APIConstants.baseUrl +
          APIConstants.editProfileEndpoint +
          "/${user.id}");
      Map<String, String> request = {
        "first_name": user.firstName,
        "last_name": user.lastName,
        "password": password
      };

      if (user.profileImage != "null") {
        request["profile_photo"] = user.profileImage;
      }

      var body = jsonEncode(request /*user.toJson()*/);
      var response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
            'Authorization': 'Bearer ${await storage.read(key: 'token')}'
          },
          body: body);

      if (response.statusCode != 200) {
        throw Exception("Update of profile did not suceed!");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //TODO: Use try-catch when using this function
  Future<void> deleteUser(int uid) async {
    mockUser.remove(uid);
    // try {
    //   var url = Uri.parse(
    //       APIConstants.baseUrl + APIConstants.deleteProfileEndpoint + "/$uid");
    //   var response = await http.delete(url);
    //   if(response.statusCode != 200) {
    //     throw Exception("Delete of profil did not suceed!");
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  Future<void> updatePassword(int uid, String password) async {
    mockPassord.remove(uid);
    mockPassord[uid] = password;
    // try {
    //   var url =
    //       Uri.parse(APIConstants.baseUrl + APIConstants.editPasswordEndpoint);
    //   var obj = {"uid": uid, "password": password};
    //   var body = jsonEncode(obj);
    //   var response = await http.post(url,
    //       headers: <String, String>{
    //         'Content-Type': 'application/json; charset=UTF-8'
    //       },
    //       body: body);
    //   if (response.statusCode != 200) {
    //     throw Exception("Update of password did not suceed!");
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  // Future<Map<String, dynamic>?> getCultivarInformation(int cultivarId) async {
  //   try {
  //     var url = Uri.parse(
  //         APIConstants.baseUrl + APIConstants.cultivarEdpoint + "/$cultivarId");
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       return json.decode(response.body);
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }

  Future<List<UploadedSpecimen>> getUploadedSpecimens() async {
    List<UploadedSpecimen> lst = [];
    try {
      var url = Uri.parse(
          APIConstants.baseUrl + APIConstants.uploadedSpecimensEndpoint);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer ${await storage.read(key: 'token')}'
      });
      // print(await storage.read(key: 'token'));
      // print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        List specimensJsonList = json.decode(response.body) as List;
        for (dynamic uploadedSpecimenJson in specimensJsonList) {
          lst.add(UploadedSpecimen.fromJson(uploadedSpecimenJson));
        }
        print(lst);
        return lst;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<Question>?> getQuiz(User user) async {
    List<Question> lst = [];

    try {
      var url = Uri.parse(
          APIConstants.baseUrl + APIConstants.quizEndpoint + "/${user.id}");
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer ${await storage.read(key: 'token')}'
      });
      if (response.statusCode == 202) {
        List questionJsonList = json.decode(response.body) as List;
        for (dynamic questionJson in questionJsonList) {
          lst.add(Question.fromJson(questionJson));
        }
        return lst;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Future<List<String>> getQuizAutocomplete() {
  //   return null;
  // }

  Future<void> setQuizAnswers(int uid, List<FormItem> answers) async {
    List<Map<String, dynamic>> lst = [];

    for (FormItem i in answers) {
      lst.add(i.getData());
    }

    if (lst.isEmpty) {
      return;
    }

    try {
      var url =
          Uri.parse(APIConstants.baseUrl + APIConstants.quizEndpoint + "/$uid");
      // var obj = {"answers": lst};
      var body = jsonEncode(lst);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
            'Authorization': 'Bearer ${await storage.read(key: 'token')}'
          },
          body: body);
      if (response.statusCode != 200) {
        throw Exception("Submission of quiz answers did not suceed!");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getRecentlyUploadedSpecimens() async {
    try {
      var url = Uri.parse(APIConstants.baseUrl +
          APIConstants.recentlyUploadedSpecimensEndpoint);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        List<Map> specimensMaps = (json.decode(response.body) as List)
            .map((specimen) => (specimen as Map))
            .toList();
        List<Map<String, dynamic>> specimens = [];

        for (Map map in specimensMaps) {
          Map<String, dynamic> newMap = {};
          for (dynamic key in map.keys) {
            newMap[key.toString()] = map[key];
          }
          specimens.add(newMap);
        }

        return specimens;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<Map<String, Object>?>?> getMapSpecimens() async {
    List<Map<String, Object>> lst = [];

    try {
      var url =
          Uri.parse(APIConstants.baseUrl + APIConstants.mapSpecimensEndpoint);
      var response = await http.get(url);
      List listOfSpecimens = json.decode(response.body) as List;
      if (response.statusCode == 200) {
        for (dynamic specimen in listOfSpecimens) {
          LatLng coordinates = LatLng(specimen["lat"], specimen["long"]);
          Map<String, Object> new_obj = {
            "coords": coordinates,
            "specimen_id": specimen["specimenId"],
            "address": specimen["address"],
            "owner": specimen["owner"],
            "epithet": specimen["cultivar"]["epithet"],
            "species": specimen["cultivar"]["species"],
            "cultivar_id": specimen["cultivar"]["cultivar_id"],
            "characteristics": specimen["cultivar"]["characteristics"],
            "photos": specimen["photos"],
            "garden": specimen["garden"]
          };
          lst.add(new_obj);
        }
        return lst;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<UpovCategory>> getUpovCharacteristics() async {
    try {
      var url = Uri.parse(
          APIConstants.baseUrl + APIConstants.upovCharacteristicsEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List specimensList = json.decode(response.body) as List;

        List<UpovCategory> categories = specimensList
            .map((catObjJson) => UpovCategory.fromJson(catObjJson))
            .toList();
        return categories;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<int> postSpecimenRequest(Map<String, dynamic> specimenToUpload) async {
    print(specimenToUpload);
    try {
      var url =
          Uri.parse(APIConstants.baseUrl + APIConstants.createSpecimenEndpoint);
      var body = jsonEncode(specimenToUpload);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
            'Authorization': 'Bearer ${await storage.read(key: 'token')}'
          },
          body: body);
      print(await storage.read(key: 'token'));
      print("specimen resquest after post\n" + response.body);
      return response.statusCode;
    } catch (e) {
      log(e.toString());
    }
    return -1;
  }

  Future<Map<String, int>> getAutocomplete(String substring) async {
    try {
      var url = Uri.parse(APIConstants.baseUrl +
          APIConstants.autocomplete +
          "?substring=$substring");
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer ${await storage.read(key: 'token')}'
      });
      if (response.statusCode == 200) {
        List<dynamic> optionsJson = json.decode(response.body) as List;
        Map<String, int> options = {};
        for (dynamic specimen in optionsJson) {
          var map = specimen as Map;
          options[map["denomination"] as String] = map["cultivarId"] as int;
        }
        return options;
      }
    } catch (e) {
      log(e.toString());
    }
    return {};
  }

  Future<Map<String, dynamic>> getCultivar(int cultivarId) async {
    var url;
    try {
      if (cultivarId == null) {
        url = Uri.parse(
            APIConstants.baseUrl + APIConstants.cultivarEdpoint + "/1");
        //"/$cultivarId");
      } else {
        url = Uri.parse(APIConstants.baseUrl +
            APIConstants.cultivarEdpoint +
            "/$cultivarId");
      }
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer ${await storage.read(key: 'token')}'
      });

      // {"id":1,"species":"C. japonica",
      // "epithet":"A. Markley Lee",
      // "description":"Fruitland Nursery Catalogue, 1943-1944, p.20: Imbricated pink similar to 'Pink Perfection' (Otome). Raised in USA.",
      // "photograph":null,"synonyms":[],"characteristicValues":[],"cultivarVotes":{}}

      if (response.statusCode == 200) {
        Map<String, dynamic> cultivarDetails = json.decode(response.body);
        cultivarDetails["characteristicValues"] = [
          {
            "category": "Leaf",
            "subcategories": [
              {"subcat": "name", "option": "option"}
            ]
          }
        ];
        return cultivarDetails;
      }
    } catch (e) {
      log(e.toString());
    }
    return {};
  }

  Future<List<String>> getCultivarPhotos(int cultivarId) async {
    var url;
    try {
      if (cultivarId == null) {
        url = Uri.parse(
            APIConstants.baseUrl + APIConstants.cultivarEdpoint + "/1/photos");
        //"/$cultivarId");
      } else {
        url = Uri.parse(APIConstants.baseUrl +
            APIConstants.cultivarEdpoint +
            "/$cultivarId/photos");
      }
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      // {"id":1,"species":"C. japonica",
      // "epithet":"A. Markley Lee",
      // "description":"Fruitland Nursery Catalogue, 1943-1944, p.20: Imbricated pink similar to 'Pink Perfection' (Otome). Raised in USA.",
      // "photograph":null,"synonyms":[],"characteristicValues":[],"cultivarVotes":{}}

      if (response.statusCode == 200) {
        List<String> cultivarPhotos = (json.decode(response.body) as List)
            .map((e) => e as String)
            .toList();
        return cultivarPhotos;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
