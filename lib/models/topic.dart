import 'user.dart';

class Topics {
  String id;
  String title;
  String description;
  String images;
  String idUser;
  String createdAt;
  String updatedAt;
  Users? users;

  Topics({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.idUser,
    required this.createdAt,
    required this.updatedAt,
    this.users,
  });

  factory Topics.fromJson(Map<String, dynamic> json) => Topics(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        images: json["images"],
        idUser: json["id_user"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "images": images,
        "id_user": idUser,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
