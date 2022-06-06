class User {
  User({
    this.id,
    this.email,
    this.imageUrl,
  });

  final String? id;
  final String? email;
  final String? imageUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "image_url": imageUrl,
      };
}
