class UserModel {
  String? email;
  String? name;
  String? phone;
  String? uId;
  bool? isEmailVerified;

  UserModel({
    this.uId,
    this.email,
    this.phone,
    this.name,
    this.isEmailVerified
  });

  UserModel.fromJson(Map<String,dynamic> json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified
    };
  }
}