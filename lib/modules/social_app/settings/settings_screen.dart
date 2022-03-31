import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_cubit.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_states.dart';
import 'package:socialapp/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:socialapp/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';

class SettingsScren extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel=SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(

                      child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0),topRight:Radius.circular(4.0)),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${userModel!.cover}'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(

                        backgroundImage: NetworkImage(
                            '${userModel!.image}'
                        ),
                        radius: 60.0,
                      ),
                    ),

                  ],
                ),
              ),
              Text(
                  '${userModel!.name}',
                  style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 5.0,),
              Container(
                width: 80.0,

                child: Text(
                  '${userModel!.bio}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '183',style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10k',style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '43',style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Following',style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: DefaultButton(onpressed: (){}, text: 'Add photos',)),
                  SizedBox(width: 15.0,),
                  IconButton(onPressed: (){
                    navigateTo(context, EditProfileScreen());
                  }, icon: Icon(Icons.edit),color: defaultColoer),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(child: DefaultButton(onpressed: (){
                    SocialCubit.get(context).logout(context);

                  }, text: 'Logout',width: 150.0)),

                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
