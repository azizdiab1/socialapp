import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_cubit.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';

class PostScreen extends StatelessWidget {
  var postTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              DefaultTextButton(text: 'Post', function: (){
                var now=DateTime.now();
                if(SocialCubit.get(context).postImage == null){
                  SocialCubit.get(context).createPost(text: postTextController.text, dateTime: now.toString());
                }else{
                  SocialCubit.get(context).uploadPostImage(text: postTextController.text, dateTime: now.toString());
                }
              })
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(

                      backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel!.image}'
                      ),
                      radius: 25.0,
                    ),
                    SizedBox(width: 20.0,),
                    Expanded(
                      child: Text(
                        '${SocialCubit.get(context).userModel!.name}',
                        style: TextStyle(height: 1.4,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postTextController,
                    decoration: InputDecoration(
                        hintText: 'What is in your mind? ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 160.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image:FileImage(SocialCubit.get(context).postImage!) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CircleAvatar(
                        radius: 18,
                        child: IconButton(onPressed: (){
                          SocialCubit.get(context).removePostImage();
                        },iconSize: 16, icon: Icon(Icons.close))),
                  ],
                ),
                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      }, child: Row(
                        children: [
                          Icon(
                              Icons.photo
                          ),
                          SizedBox(width: 5,),
                          Text('Add photo')
                        ],
                      ),),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){}, child:
                      Text(
                        '#tags'
                      )
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
