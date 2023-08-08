import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../config/api.dart';
import '../models/comment.dart';

class CommnetSource {
  static Future<bool> create(String comment, String image, String base64code,
      String fromIdUser, String toIdUser, String idTopic) async {
    String url = '${Api.comment}/create.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_topic': idTopic,
        'comment': comment,
        'image': image,
        'base64code': base64code,
        'to_id_user': toIdUser,
        'from_id_user': fromIdUser,
      });
      DMethod.printTitle('Comment Source - Create Comment', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Comment Source - Create Comment', e.toString());
      return false;
    }
  }

  static Future<bool> delete(String image, String id) async {
    String url = '${Api.comment}/delete.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'image': image,
      });
      DMethod.printTitle('Comment Source - Delete Comment', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Comment Source - Delete Comment', e.toString());
      return false;
    }
  }

  static Future<List<Comments>> readComment(String idTopic) async {
    String url = '${Api.comment}/read.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_topic': idTopic,
      });
      DMethod.printTitle('Comment Source - Read Comment', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Comments.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Comment Source - Read Comment', e.toString());
      return [];
    }
  }
}
