import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/social_app/social_cubit/social_states.dart';
import 'package:socialapp/models/social/message_model.dart';
import 'package:socialapp/models/social/post_model.dart';
import 'package:socialapp/models/social/social_user_model.dart';
import 'package:socialapp/modules/social_app/add_post/post_screen.dart';
import 'package:socialapp/modules/social_app/chats/chats_screen.dart';
import 'package:socialapp/modules/social_app/feeds/feeds_screen.dart';
import 'package:socialapp/modules/social_app/settings/settings_screen.dart';
import 'package:socialapp/modules/social_app/social_login_screen/cubit/social_login_states.dart';
import 'package:socialapp/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:socialapp/modules/social_app/users/users_screen.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';
import 'package:socialapp/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialIntialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  // String? uId=CashHelper.get(key: 'uId');
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      emit(SocialGetUserSuccessState());

      userModel = SocialUserModel.fromJson(value.data()!);
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostScreen(),
    UsersScren(),
    SettingsScren()
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if(index == 0&&posts.length==0){
      getUserData();
      getPosts();
    }

    if (index == 2) {
      print(currentIndex);
      emit(SocialPostScreenState());
    } else {
      currentIndex = index;
      print(index);
      print(currentIndex);
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  File? postImage;

  void removePostImage() {
    emit(SocialPostImageRemovedSuccessState());
    postImage = null;
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required name,
    required phone,
    required bio,
  }) {
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(phone: phone, name: name, bio: bio, profile: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print('Error is ${error.toString()}');
    });
  }

  void uploadCoverImage({
    required name,
    required phone,
    required bio,
  }) {
    emit(SocialUpdateUserDataLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(phone: phone, name: name, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
      print('Error is ${error.toString()}');
    });
  }

  void uploadPostImage({
    required text,
    required dateTime,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, dateTime: dateTime, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
      print('Error is ${error.toString()}');
    });
  }

  void createPost({
    required text,
    String? postImage,
    required dateTime,
  }) {
    emit(SocialCreatePostLoadingState());
    SocialPostModel model = SocialPostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      psotImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void updateUser({
    required String phone,
    required String name,
    required String bio,
    String? cover,
    String? profile,
  }) {
    emit(SocialUpdateUserDataLoadingState());
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      bio: bio,
      cover: cover ?? userModel!.cover,
      image: profile ?? userModel!.image,
      email: userModel!.email,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      emit(SocialUpdateUserDataSuccessState());
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserDataErrorState());
    });
  }

  List<SocialPostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  List<SocialUserModel> users = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(SocialPostModel.fromJson(element.data()));
          emit(SocialGetPostsSuccessState());
        }).catchError((error) {});
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          print(comments);
          emit(SocialGetPostsSuccessState());
        });
        emit(SocialGetPostsSuccessState());
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error));
    });
  }

  void commentPost(String postId, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': comment}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error));
    });
  }

  void getUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  void sendMessages({
    required String recieverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      dateTime: dateTime,
      recieverId: recieverId,
      senderId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMeassageSuccessState());
    }).catchError((error) {
      emit(SocialSendMeassageErrorState(error));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMeassageSuccessState());
    }).catchError((error) {
      emit(SocialSendMeassageErrorState(error));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String recieverId}) {

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages=[];
      event.docs.forEach((element) {

        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMeassageSuccessState());
    });
  }
  void logout( context){
    emit(SocialLogoutSuccessState());

    CashHelper.removeData(key: 'uId');
    uId=null;
    navigateAndFinish(context, SocialLoginScreen());
    posts=[];
    currentIndex=0;


  }
}
