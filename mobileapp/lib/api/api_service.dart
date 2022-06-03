import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:camellia_cultivar/model/coordinates.dart';
import 'package:camellia_cultivar/model/question.dart';
import 'package:camellia_cultivar/model/uploaded_specimen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

import '../quiz_page.dart';
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
      if (response.statusCode == 202) {
        User api_user = userFromJson(response.body, uid);
        print("user from api" + api_user.toString());
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
      // print(url);
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
      throw e;
    }
    return [-1, "Failed to create account. Please try again later!"];
  }

  //TODO: Use try-catch when using this function
  Future<void> updateUser(User user, String password) async {
    // mockUser.remove(user.id);
    // mockUser[user.id] = user;

    try {
      var url =
          Uri.parse(APIConstants.baseUrl + APIConstants.editProfileEndpoint);
      print(user);
      Map<String, String> request = {
        "email": user.email,
        "profile_image": user.profileImage,
        "first_name": user.firstName,
        "last_name": user.lastName,
        "password": password
      };
      var body = jsonEncode(request /*user.toJson()*/);
      print(body);
      var response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
            'Authorization': 'Bearer ${await storage.read(key: 'token')}'
          },
          body: body);
      print(response.body);

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

  Future<Map<String, dynamic>?> getCultivarInformation(int cultivarId) async {
    try {
      var url = Uri.parse(
          APIConstants.baseUrl + APIConstants.cultivarEdpoint + "/$cultivarId");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<UploadedSpecimen>?> getUploadedSpecimens(int uid) async {
    List<UploadedSpecimen> lst = [];
    try {
      var url = Uri.parse(APIConstants.baseUrl +
          APIConstants.uploadedSpecimensEndpoint +
          "/$uid");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        for (dynamic o in json.decode(response.body)) {
          lst.add(UploadedSpecimen.fromJson(json.decode(o)));
        }
        return lst;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Question>?> getQuiz() async {
    List<Question> lst = [];

    try {
      var url = Uri.parse(APIConstants.baseUrl + APIConstants.quizEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        for (dynamic o in json.decode(response.body)) {
          lst.add(Question.fromJson(json.decode(o)));
        }
        return lst;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> setQuizAnswers(int uid, List<FormItem> answers) async {
    List<Map<String, dynamic>> lst = [];

    for (FormItem i in answers) {
      lst.add(i.getData());
    }

    try {
      var url = Uri.parse(APIConstants.baseUrl + APIConstants.quizEndpoint);
      var obj = {"uid": uid, "answers": lst};
      var body = jsonEncode(obj);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);
      if (response.statusCode != 200) {
        throw Exception("Submission of quiz answers did not suceed!");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Map<String, dynamic>?>?> getRecentlyUploadedSpecimens() async {
    try {
      var url = Uri.parse(APIConstants.baseUrl +
          APIConstants.recentlyUploadedSpecimensEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Map<String, dynamic>?>?> getMapSpecimens() async {
    List<Map<String, dynamic>> lst = [];

    try {
      var url =
          Uri.parse(APIConstants.baseUrl + APIConstants.mapSpecimensEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        for (dynamic obj in json.decode(response.body)) {
          LatLng coordinates =
              LatLng(double.parse(obj["lat"]), double.parse(obj["long"]));
          Map<String, dynamic> new_obj = {
            "coords": coordinates,
            "name": obj["name"],
            "image": obj["image"],
            "camellia_id": obj["camellia_id"]
          };
          lst.add(new_obj);
        }
      }
      return lst;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
