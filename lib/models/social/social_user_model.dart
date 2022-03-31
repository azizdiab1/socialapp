class SocialUserModel{
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;
  SocialUserModel({this.email,this.phone,this.name,this.uId,this.isEmailVerified,this.image,this.bio,this.cover});
  SocialUserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    uId=json['uId'];
    bio=json['bio'];
    image=json['image'];
    cover=json['cover'];
    isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
      'bio':bio,
      'image':image,
      'cover':cover,
      'isEmailVerified':isEmailVerified,
    };
  }
}