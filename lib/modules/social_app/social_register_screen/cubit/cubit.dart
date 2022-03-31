import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/social/social_user_model.dart';
import 'package:socialapp/modules/social_app/social_register_screen/cubit/states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(SocialRegisterIntialState());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);
  bool isPasword=true;
  IconData sufix=Icons.visibility;
  void changePasswordvisibility(){
    isPasword=!isPasword;

      sufix= isPasword? Icons.visibility:Icons.visibility_off;
     emit(SocialRegisterIconState());
  }
  void userRegister({
  required String email,
  required String password,
    required String phone,
    required String name,
}){
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password,

    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
         uId: value.user!.uid,
        email:email,
        name: name,
        phone: phone,
      );
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String phone,
    required String name,
    required uId,
  }){
    emit(SocialCreateUserLoadingState());
    SocialUserModel userModel=SocialUserModel(
      phone: phone,
      name: name,
      email: email,
      uId: uId,
      bio: 'write your bio...',
      cover: 'https://img.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg?t=st=1648023850~exp=1648024450~hmac=f025f206827874356cc1770221444bb88321e8d66324b3414ef42c2ceba45128&w=996',
      image: 'https://img.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg?t=st=1648023850~exp=1648024450~hmac=f025f206827874356cc1770221444bb88321e8d66324b3414ef42c2ceba45128&w=996',
      isEmailVerified: false,

  );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId).set(userModel.toMap())
        .then((value){
          emit(SocialCreateUserSuccessState());
    }).catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

}