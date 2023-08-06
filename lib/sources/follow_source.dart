import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../config/api.dart';
import '../models/user.dart';

class FollowSource {
  static Future<bool> checkIsFollowing(
      String fromIdUser, String toIdUser) async {
    String url = '${Api.follow}/check.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
      });
      DMethod.printTitle('Follow Source - Check Is Following', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Follow Source - Check Is Following', e.toString());
      return false;
    }
  }

  static Future<bool> following(String fromIdUser, String toIdUser) async {
    String url = '${Api.follow}/following.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
      });
      DMethod.printTitle('Follow Source - Following', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Follow Source - Following', e.toString());
      return false;
    }
  }

  static Future<bool> unFollowing(String fromIdUser, String toIdUser) async {
    String url = '${Api.follow}/unfollow.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'from_id_user': fromIdUser,
        'to_id_user': toIdUser,
      });
      DMethod.printTitle('Follow Source - Unfollow', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Follow Source - Unfollow', e.toString());
      return false;
    }
  }

  static Future<List<Users>> readFollower(String idUser) async {
    String url = '${Api.follow}/read_follower.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': idUser,
      });
      DMethod.printTitle('follow Source - Read Follower', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Users.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('follow Source - Read Follower', e.toString());
      return [];
    }
  }

  static Future<List<Users>> readFollowing(String idUser) async {
    String url = '${Api.follow}/read_following.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': idUser,
      });
      DMethod.printTitle('follow Source - Read Following', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Users.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('follow Source - Read Following', e.toString());
      return [];
    }
  }
}
