import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../config/api.dart';
import '../models/topic.dart';

class TopicSource {
  static Future<bool> create(String title, String description, String images,
      String base64codes, String idUser) async {
    String url = '${Api.topic}/create.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'title': title,
        'description': description,
        'images': images,
        'base64codes': base64codes,
        'id_user': idUser,
      });
      DMethod.printTitle('Topic Source - Create Topic', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - Create Topic', e.toString());
      return false;
    }
  }

  static Future<bool> update(
      String id, String title, String description) async {
    String url = '${Api.topic}/update.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'title': title,
        'description': description,
      });
      DMethod.printTitle('Topic Source - Update Topic', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - Update Topic', e.toString());
      return false;
    }
  }

  static Future<bool> delete(String id, String images) async {
    String url = '${Api.topic}/delete.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'images': images,
      });
      DMethod.printTitle('Topic Source - delete Topic', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - delete Topic', e.toString());
      return false;
    }
  }

  static Future<List<Topics>> readExplore() async {
    String url = '${Api.topic}/read_explor.php';

    try {
      Response response = await Client().get(Uri.parse(url));
      DMethod.printTitle('Topic Source - Read Explore', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topics.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - Read Explore', e.toString());
      return [];
    }
  }

  static Future<List<Topics>> readFeed(String idUser) async {
    String url = '${Api.topic}/read_feed.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': idUser,
      });
      DMethod.printTitle('Topic Source - Read Feed', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topics.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - Read Feed', e.toString());
      return [];
    }
  }

  static Future<List<Topics>> readUserTopic(String idUser) async {
    String url = '${Api.topic}/read_user_topic.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': idUser,
      });
      DMethod.printTitle('Topic Source - Read User Topic', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topics.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - Read User Topic', e.toString());
      return [];
    }
  }

  static Future<List<Topics>> search(String searchQuery) async {
    String url = '${Api.topic}/search.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'search_query': searchQuery,
      });
      DMethod.printTitle('Topic Source - Search Topic', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topics.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - Search Topic', e.toString());
      return [];
    }
  }
}
