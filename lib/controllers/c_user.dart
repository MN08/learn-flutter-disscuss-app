import 'package:flutter/foundation.dart';
import '../models/user.dart';

class CUser extends ChangeNotifier {
  Users? _data;
  Users? get data => _data;
  set data(Users? n) {
    _data = n;
    notifyListeners();
  }
}
