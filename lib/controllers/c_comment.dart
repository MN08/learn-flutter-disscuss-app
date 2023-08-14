import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../models/comment.dart';
import '../models/topic.dart';
import '../models/user.dart';
import '../sources/comment_source.dart';

class CComment extends ChangeNotifier {
  List<Comments> _comments = [];
  List<Comments> get comments => _comments;
  setComments(Topics topic) async {
    _image = '';
    _imageBase64Code = '';
    _comments = await CommentSource.readComment(topic.id);
    setReplyTo(topic.users!);
    notifyListeners();
  }

  Users? _replyTo;
  Users? get replyTo => _replyTo;
  setReplyTo(Users user) {
    _replyTo = user;
    notifyListeners();
  }

  String _image = '';
  String get image => _image;

  String _imageBase64Code = '';
  String get imageBase64Code => _imageBase64Code;

  pickImage(ImageSource source) async {
    XFile? result = await ImagePicker().pickImage(source: source);
    if (result != null) {
      _image = result.name;
      _imageBase64Code = base64Encode(await result.readAsBytes());
      notifyListeners();
    }
  }
}
