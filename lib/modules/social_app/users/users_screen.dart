import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_cubit.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_states.dart';
import 'package:socialapp/models/social/social_user_model.dart';
import 'package:socialapp/shared/components/components.dart';

class UsersScren extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length>0,
          builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(context,SocialCubit.get(context).users[index]),
              separatorBuilder: (context, index) => myDevider(),
              itemCount: SocialCubit.get(context).users.length
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(context,SocialUserModel model)=>InkWell(
    onTap: (){
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
      child: Row(
        children: [
          CircleAvatar(

            backgroundImage: NetworkImage(
                '${model.image}'
            ),
            radius: 25.0,
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${model.name}',
                      style: TextStyle(height: 1.4,fontWeight: FontWeight.bold),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}
