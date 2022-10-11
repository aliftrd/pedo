class UserModel {
  String? name, email, image, level, token;
  int? created_at, updated_at;

  UserModel(
    this.name,
    this.email,
    this.image,
    this.level,
    this.token,
    this.created_at,
    this.updated_at,
  );

  // User model from json
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
    level = json['level'];
    token = json['token'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'level': level,
      'token': token,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}
