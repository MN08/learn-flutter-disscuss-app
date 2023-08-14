import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../sources/follow_source.dart';

class CFollowing extends ChangeNotifier {
  List<Users> _following = [];
  List<Users> get following => _following;
  setFollowing(String idUser) async {
    _following = await FollowSource.readFollowing(idUser);
    notifyListeners();
  }
}
