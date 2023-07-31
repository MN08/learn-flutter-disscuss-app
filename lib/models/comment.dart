import 'user.dart';

class Comments {
  String id;
  String idTopic;
  String fromIdUser;
  String toIdUser;
  String comment;
  String image;
  String createdAt;
  String updatedAt;
  Users fromUser;
  Users toUser;

  Comments({
    required this.id,
    required this.idTopic,
    required this.fromIdUser,
    required this.toIdUser,
    required this.comment,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.fromUser,
    required this.toUser,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        id: json["_id"],
        idTopic: json["id_topic"],
        fromIdUser: json["from_id_user"],
        toIdUser: json["to_id_user"],
        comment: json["comment"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        fromUser: Users.fromJson(json["from_user"]),
        toUser: Users.fromJson(json["to_user"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id_topic": idTopic,
        "from_id_user": fromIdUser,
        "to_id_user": toIdUser,
        "comment": comment,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "from_user": fromUser.toJson(),
        "to_user": toUser.toJson(),
      };
}
