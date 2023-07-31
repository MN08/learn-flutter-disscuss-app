class Users {
  String id;
  String username;
  String password;
  String image;
  String createdAt;
  String updatedAt;

  Users({
    required this.id,
    required this.username,
    required this.password,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["_id"],
        username: json["username"],
        password: json["password"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
