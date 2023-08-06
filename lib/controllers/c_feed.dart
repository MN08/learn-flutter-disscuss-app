import 'package:flutter/foundation.dart';
import 'package:learn_flutter_discuss_app/models/topic.dart';
import 'package:learn_flutter_discuss_app/sources/topic_source.dart';

class CFeed extends ChangeNotifier {
  List<Topics> _topics = [];
  List<Topics> get topics => _topics;
  setTopics(String idUser) async {
    _topics = await TopicSource.readFeed(idUser);
    notifyListeners();
  }
}
