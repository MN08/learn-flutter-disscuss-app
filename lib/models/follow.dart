class Follows {
  String id;
  String fromIdUser;
  String toIdUser;
  String createdAt;
  String updatedAt;

  Follows({
    required this.id,
    required this.fromIdUser,
    required this.toIdUser,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Follows.fromJson(Map<String, dynamic> json) => Follows(
        id: json["id"],
        fromIdUser: json["from_id_user"],
        toIdUser: json["to_id_user"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_id_user": fromIdUser,
        "to_id_user": toIdUser,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
