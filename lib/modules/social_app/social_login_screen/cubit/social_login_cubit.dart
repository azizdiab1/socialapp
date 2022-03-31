import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_cubit.dart';
import 'package:socialapp/modules/social_app/social_login_screen/cubit/social_login_states.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super(SocialLoginIntialState());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);
  bool isPassword=true;
  IconData passwordSufixIcon=Icons.visibility;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    if(isPassword){
      passwordSufixIcon=Icons.visibility;
      emit(SocialLoginChangePasswordVisibilityState());
    }else{
      passwordSufixIcon=Icons.visibility_off;
      emit(SocialLoginChangePasswordVisibilityState());
    }
  }
  
  void userLogin({
  required email,
    required password,
}){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
      print(error.toString());
    });
}

}