
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_cubit.dart';
import 'package:socialapp/layout/social_app/social_layout.dart';
import 'package:socialapp/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:socialapp/shared/blic_observer.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/cubit/app_cubit.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';
import 'package:socialapp/shared/network/remote/dio_helper.dart';
import 'package:socialapp/shared/style/themes.dart';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import 'shared/cubit/app_states.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Firebase.initializeApp();
  var tokenn=FirebaseMessaging.instance.getToken().then((value) {
    print('This is your token $value');
  });

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    print(event.notification.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    print(event.notification.toString());
  });
  await CashHelper.init();
  bool? isDark=CashHelper.get(key: 'isDark');
  // bool? onBoarding=CashHelper.get(key: 'onBoarding');
   String? token=CashHelper.get(key: 'token');
  Widget widget;
  // if(onBoarding != null){
  //   if(token != null){
  //     widget=ShopLayout();
  //   }else{
  //     widget=ShopLoginScreen();
  //   }
  // }else{
  //   widget=OnBoardingScreen();
  // }

  if(uId != null){
    widget=SocialLayout();
    print('this is $uId');
  }else{
    widget=SocialLoginScreen();
    print('this is $uId');
  }
  BlocOverrides.runZoned(() {
    SocialLoginScreen();
    runApp(MyApp(widget: widget,));
  }, blocObserver: SimpleBlocObserver());

}



class MyApp extends StatelessWidget {
 // final bool isDark;
  var widget;
  MyApp({this.widget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
            BlocProvider(create: (context)=>AppCubit()),
            // BlocProvider(
            //   create: (context) => ShopCubit()..getData()..getCategories()..getFavorites()..getUserData(),
            // ),
        BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
             // darkTheme: darkTheme,
              theme: lightTheme,
              //themeMode: NewsAppCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
              home: widget,
            );
          }
      ),
    );

  }
}

