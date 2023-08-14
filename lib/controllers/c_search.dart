import 'package:flutter/foundation.dart';

import '../models/topic.dart';
import '../models/user.dart';
import '../sources/topic_source.dart';
import '../sources/user_source.dart';

class CSearch extends ChangeNotifier {
  List<String> get filters => ['Topic', 'User'];
  String _filter = 'Topic';
  String get filter => _filter;
  set filter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  search(String query) {
    if (filter == 'Topic') {
      setTopics(query);
    } else {
      setUsers(query);
    }
  }

  List<Topics> _topics = [];
  List<Topics> get topics => _topics;
  setTopics(String searchQuery) async {
    _topics = await TopicSource.search(searchQuery);
    notifyListeners();
  }

  List<Users> _users = [];
  List<Users> get users => _users;
  setUsers(String query) async {
    _users = await UserSource.search(query);
    notifyListeners();
  }
}
