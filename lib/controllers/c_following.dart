import 'package:flutter/foundation.dart';
import 'package:learn_flutter_discuss_app/models/user.dart';
import 'package:learn_flutter_discuss_app/sources/follow_source.dart';

class CFollowing extends ChangeNotifier {
  List<Users> _following = [];
  List<Users> get following => _following;
  setFollowing(String idUser) async {
    _following = await FollowSource.readFollowing(idUser);
    notifyListeners();
  }
}
