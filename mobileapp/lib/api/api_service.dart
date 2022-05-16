import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'api_constants.dart';
import '../model/user.dart';

Map<int, User> mockUser = {
  0: User(
      id: 0,
      firstName: "John",
      lastName: "Doe",
      email: "jd@ua.pt",
      //password: "12345",
      reputation: 0,
      profileImage: "https://i.imgflip.com/2/1975nj.jpg")
};

Map<int, String> mockPassord = {0: "12345"};

class APIService {
  Future<int?> login(String email, String password) async {
    // try {
    //   var url = Uri.parse(APIConstants.baseUrl + APIConstants.loginEndpoint);
    //   var obj = {"email": email, "password": password};
    //   var body = jsonEncode(obj);
    //   var response = await http.post(url,
    //       headers: <String, String>{
    //         'Content-Type': 'application/json; charset=UTF-8'
    //       },
    //       body: body);
    //   if (response.statusCode == 200) {
    //     return int.parse(response.body);
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
    // return null;
    return 0;
  }

  Future<User?> getUser(int uid) async {
    //  try {
    //     var url = Uri.parse(APIConstants.baseUrl + APIConstants.profileEndpoint + "/$uid");
    //     var response = await http.get(url);
    //     if (response.statusCode == 200) {
    //       User _model = userFromJson(response.body);
    //       print(_model.toString());
    //       return _model;
    //     }
    //   } catch (e) {
    //     log(e.toString());
    //   }
    //   return null;
    // }
    return mockUser[uid];
  }

  Future<int?> createUser(User user) async {
    // try {
    //   var url = Uri.parse(APIConstants.baseUrl + APIConstants.registerEndpoint);
    //   var body = jsonEncode(user.toJson());
    //   var response = await http.post(url,
    //       headers: <String, String>{
    //         'Content-Type': 'application/json; charset=UTF-8'
    //       },
    //       body: body);
    //   if (response.statusCode == 200) {
    //     return int.parse(response.body);
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
    // return null;
    mockUser[user.id] = user;
    return user.id;
  }

  // TODO: Use try-catch when using this function
  Future<void> updateUser(User user) async {
    mockUser.remove(user.id);
    mockUser[user.id] = user;

    // try {
    //   var url =
    //       Uri.parse(APIConstants.baseUrl + APIConstants.editProfileEndpoint);
    //   var body = jsonEncode(user.toJson());
    //   var response = await http.post(url,
    //       headers: <String, String>{
    //         'Content-Type': 'application/json; charset=UTF-8'
    //       },
    //       body: body);
    //   if (response.statusCode != 200) {
    //     throw Exception("Update of profile did not suceed!");
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  // TODO: Use try-catch when using this function
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
    //     throw Exception("Update of profile did not suceed!");
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
  }
}
