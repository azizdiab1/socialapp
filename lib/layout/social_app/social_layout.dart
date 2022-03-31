import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_cubit.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_states.dart';
import 'package:socialapp/modules/social_app/add_post/post_screen.dart';
import 'package:socialapp/modules/social_app/social_login_screen/cubit/social_login_states.dart';
import 'package:socialapp/shared/components/components.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        if(state is SocialPostScreenState){
          navigateTo(context, PostScreen());
        }
      },
      builder: (context, state) {
        var cubit=SocialCubit.get(context);
        return Scaffold(

          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none)),
              IconButton(onPressed: (){}, icon: Icon(Icons.search)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNav(index);
            },

              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chats' ),
                BottomNavigationBarItem(icon: Icon(Icons.upload_file),label: 'Post', ),
                BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Users'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings' ),

              ]
          ),
          body: cubit.screens[cubit.currentIndex],
        );
    }
    );

  }
}
