import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_cubit.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_states.dart';
import 'package:socialapp/models/social/post_model.dart';
import 'package:socialapp/modules/social_app/comments_likes/comments_likes.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';


class FeedsScreen extends StatelessWidget {
  var commentController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return ConditionalBuilder(
          condition:SocialCubit.get(context).userModel != null && SocialCubit.get(context).posts.length >0  ,
            builder: (context)=>RefreshIndicator(
              onRefresh:() {return refresh(context);},
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      elevation: 5.0,
                      margin: EdgeInsets.all(8.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-photo/curious-bearded-man-points-ay-copy-space-yellow-wall-demonstrates-important-information-found-solution-answer-question-says-his-suggestion-wears-yellow-jumper-round-spectacles_273609-37531.jpg?t=st=1647776822~exp=1647777422~hmac=5a34e2272c606089e51e51232b651ffb7ccfc53d9c01f3f276cca9765535acd4&w=996'
                              ),
                              fit: BoxFit.cover,
                              height: 200.0,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Comunicate with freinds',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(context,SocialCubit.get(context).posts[index],index),
                      separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
                      itemCount: SocialCubit.get(context).posts.length,
                    ),
                    SizedBox(height: 10.0,),
                  ],
                ),
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

Widget buildPostItem(context,SocialPostModel postModel,index)=>   Card(
  elevation: 7.0,
  margin: EdgeInsets.symmetric(horizontal: 8.0),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(

                backgroundImage: NetworkImage(
                    '${postModel.image}'
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
                          '${postModel.name}',
                          style: TextStyle(height: 1.4,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5.0,),
                        Icon(Icons.check_circle,color: defaultColoer,size: 16.0,)
                      ],
                    ),
                    Text('${postModel.dateTime}',style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4)),

                  ],
                ),
              ),
              SizedBox(width: 20.0,),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz,size: 20.0,))
            ],
          ),
          myDevider(),
          Text(
            '${postModel.text}',
            style: TextStyle(color: Colors.black,height: 1.3,fontWeight: FontWeight.w500),

          ),
          SizedBox(height: 15,),
          Container(
            width: double.infinity,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6.0),
                  child: Container(
                    height: 20.0,
                    child: MaterialButton(
                      onPressed: (){},
                      child: Text(
                        '#softWare',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: defaultColoer,
                            fontSize: 14.0
                        ),),
                      padding: EdgeInsets.zero,
                      minWidth: 1.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6.0),
                  child: Container(
                    height: 20.0,
                    child: MaterialButton(
                      onPressed: (){},
                      child: Text(
                        '#development',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: defaultColoer,
                            fontSize: 14
                        ),),
                      padding: EdgeInsets.zero,
                      minWidth: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if(postModel.psotImage!.isEmpty != true )
            Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: NetworkImage(
                      '${postModel.psotImage}'
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 10,right: 10),
            child: Row(
                children:[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: InkWell(
                        onTap: (){},
                        child: Row(
                          children: [
                            Icon(Icons.favorite_outline,color: Colors.red,size: 16.0,),
                            SizedBox(width: 2.0,),
                            Text('${SocialCubit.get(context).likes[index]}',style: Theme.of(context).textTheme.caption,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: InkWell(
                        onTap: (){
                          navigateTo(context, CommentScreen());

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.comment_outlined,color: Colors.amber,size: 16.0,),
                            SizedBox(width: 2.0,),
                            Text('${SocialCubit.get(context).comments[index]} comments',style: Theme.of(context).textTheme.caption,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
          myDevider(),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(

                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'
                      ),
                      radius: 18.0,
                    ),
                    SizedBox(width: 20.0,),
                    Flexible(
                      child: Container(
                        height: 35,
                        child: TextFormField(
                          controller: commentController,
                        decoration: InputDecoration(
                         border: InputBorder.none,
                          hintText: 'Write Your Comment..',
                          suffixIcon: IconButton(onPressed: (){
                            SocialCubit.get(context).commentPost(SocialCubit.get(context).postsId[index],commentController.text);
                            commentController.text='';
                          }, icon: Icon(Icons.send))
                        ),
                      ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                  onTap: (){
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.favorite_outline,color: Colors.red,size: 18.0,),
                      SizedBox(width: 2.0,),
                      Text('Like',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]
    ),
  ),
);
  Future <void> refresh(context) async {
    SocialCubit.get(context).getPosts();
  }
}

