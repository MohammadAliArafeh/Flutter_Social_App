class PostModel {
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? postText;
  String? dateTime;

  PostModel({
    this.uId,
    this.name,
    this.image,
    this.dateTime,
    this.postImage,
    this.postText,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    postText = json['postText'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'postText': postText,
    };
  }
}
