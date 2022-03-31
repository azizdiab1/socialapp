class SocialPostModel{
  String? name;
  String? uId;
  String? image;
  String? psotImage;
  String? text;
  String? dateTime;
  SocialPostModel({
   this.name,
    this.uId,
    this.image,
    this.text,
    this.dateTime,
    this.psotImage,
  });
  SocialPostModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    uId=json['uId'];
    image=json['image'];
    psotImage=json['psotImage'];
    text=json['text'];
    dateTime=json['dateTime'];
  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'dateTime':dateTime,
      'text':text,
      'uId':uId,
      'psotImage':psotImage,
      'image':image,
    };
  }
}