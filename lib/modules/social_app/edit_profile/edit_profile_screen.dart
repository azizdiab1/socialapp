


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_cubit.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_states.dart';
import 'package:socialapp/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel=SocialCubit.get(context).userModel;
        var profileimage=SocialCubit.get(context).profileImage;
        var coverimage=SocialCubit.get(context).coverImage;
        nameController.text=userModel!.name!;
        bioController.text=userModel!.bio!;
        phoneController.text=userModel!.phone!;
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                DefaultButton(onpressed: (){
                  SocialCubit.get(context).updateUser(phone: phoneController.text, name: nameController.text, bio: bioController.text);
                }, text: 'Update',textColor:Colors.blue,width: 100,height: 100,background: Colors.white,)
              ]
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUpdateUserDataLoadingState)
                    SizedBox(height: 10,),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(

                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0),topRight:Radius.circular(4.0)),
                                  image: DecorationImage(
                                    image: coverimage == null ?NetworkImage(
                                        '${userModel!.cover}'
                                    ): FileImage(coverimage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                  radius: 18,
                                  child: IconButton(onPressed: (){
                                    SocialCubit.get(context).getCoverImage();
                                  },iconSize: 16, icon: Icon(Icons.camera_alt_outlined))),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(

                                backgroundImage: profileimage == null ? NetworkImage(
                                    '${userModel!.image}'
                                ) : FileImage(profileimage )as ImageProvider,
                                radius: 60.0,
                              ),
                            ),
                            CircleAvatar(
                                radius: 18,
                                child: IconButton(onPressed: (){SocialCubit.get(context).getProfileImage();},iconSize: 16, icon: Icon(Icons.camera_alt_outlined))),
                          ],
                        ),

                      ],
                    ),
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                    Row(
                    children: [
                      if(SocialCubit.get(context).profileImage != null )
                        Expanded(
                        child:Column(
                          children: [
                          SizedBox(height: 5,),
                          DefaultButton(onpressed: (){
                            SocialCubit.get(context).uploadProfileImage(name: nameController.text,phone:  phoneController.text,bio:  bioController.text);
                          }, text: 'Upload Profile'),
                        ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                        child:Column(
                          children: [
                            SizedBox(height: 5,),
                            DefaultButton(onpressed: (){
                              SocialCubit.get(context).uploadCoverImage(name: nameController.text,phone:  phoneController.text,bio:  bioController.text);
                            }, text: 'Upload Cover'),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                     controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.person,),suffixIcon:Icon(Icons.edit),label: Text('Name'),border: OutlineInputBorder()),
                    validator: (text){
                       if(text!.isEmpty){
                         return'Must not be embty';
                       }
                    },

                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(prefixIcon: Icon(
                      Icons.info_outlined,
                    ),label: Text('Bio'),suffixIcon:Icon(Icons.edit),border: OutlineInputBorder()),
                    validator: (text){
                      if(text!.isEmpty){
                        return'Must not be embty';
                      }
                    },

                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(prefixIcon: Icon(
                      Icons.phone,
                    ),label: Text('Phone'),suffixIcon:Icon(Icons.edit),border: OutlineInputBorder()),
                    validator: (text){
                      if(text!.isEmpty){
                        return'Must not be embty';
                      }
                    },

                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
