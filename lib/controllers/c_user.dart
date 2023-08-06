import 'package:flutter/foundation.dart';
import 'package:learn_flutter_discuss_app/models/user.dart';

class CUser extends ChangeNotifier {
  Users? _data;
  Users? get data => _data;
  set data(Users? n) {
    _data = n;
    notifyListeners();
  }
}
