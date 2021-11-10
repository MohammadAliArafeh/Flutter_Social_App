class UserModel {
  String? email;
  String? name;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? coverImage;
  String? bio;

  UserModel({
    this.uId,
    this.email,
    this.phone,
    this.name,
    this.isEmailVerified,
    this.image,
    this.bio,
    this.coverImage
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    image = json['image'];
    coverImage = json['coverImage'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'coverImage': coverImage,
      'bio': bio,
    };
  }
}
