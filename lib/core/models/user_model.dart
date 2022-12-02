class UserModel {
  String? name, email, image, level, token, createdAt, updatedAt;

  UserModel(
    this.name,
    this.email,
    this.image,
    this.level,
    this.token,
    this.createdAt,
    this.updatedAt,
  );

  // User model from json
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
    level = json['level'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'level': level,
      'token': token,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
