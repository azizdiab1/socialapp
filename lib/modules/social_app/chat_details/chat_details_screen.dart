import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_cubit.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_states.dart';
import 'package:socialapp/models/social/message_model.dart';
import 'package:socialapp/models/social/social_user_model.dart';
import 'package:socialapp/shared/components/constants.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel userModel;

  ChatDetailsScreen({required this.userModel});
  var messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(recieverId: userModel!.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {

      },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                      SizedBox(width: 15,),
                      Text('${userModel.name}'),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(itemBuilder: (context, index) {
                          var message =SocialCubit.get(context).messages[index];
                          if(SocialCubit.get(context).userModel!.uId == message.senderId){
                            return builedMyMessage(message);
                          }else{
                            return builedMessage(message);
                          }
                        }, separatorBuilder: (context, index)=>SizedBox(height: 15,),
                            itemCount: SocialCubit.get(context).messages.length),
                      ),

                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            )
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here'
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: defaultColoer,
                              child: MaterialButton(
                                minWidth: 1,
                                onPressed: () {
                                  SocialCubit.get(context).sendMessages(
                                      recieverId: userModel.uId!,
                                      text: messageController.text,
                                      dateTime: DateTime.now().toString()
                                  );
                                  messageController.text='';
                                },
                                child: Icon(
                                  Icons.send, color: Colors.white, size: 16,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            );
          }
      );
    },);
  }

  Widget builedMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10)
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text('${model.text}')),
      );

  Widget builedMyMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            decoration: BoxDecoration(
              color: defaultColoer.withOpacity(0.2),
              borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10)
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text('${model.text}')),
      );
}
