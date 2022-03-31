class MessageModel{
  String? senderId;
  String? recieverId;
  String? dateTime;
  String? text;
  MessageModel({this.senderId,this.text,this.dateTime,this.recieverId});
  MessageModel.fromJson(Map<String,dynamic>json){
    senderId=json['senderId'];
    text=json['text'];
    dateTime=json['dateTime'];
    recieverId=json['recieverId'];
  }
  Map<String,dynamic> toMap(){
    return{
      'recieverId':recieverId,
      'text':text,
      'dateTime':dateTime,
      'senderId':senderId,

    };
  }
}