abstract class SocialStates{}
class SocialIntialState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;
  SocialGetPostsErrorState(this.error);
}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{
  final String error;
  SocialGetAllUsersErrorState(this.error);
}
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{
  final String error;
  SocialLikePostErrorState(this.error);
}
class SocialCommentPostSuccessState extends SocialStates{}
class SocialCommentPostErrorState extends SocialStates{
  final String error;
  SocialCommentPostErrorState(this.error);
}
class SocialChangeBottomNavState extends SocialStates{}
class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}
class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}
class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImageRemovedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}
class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}
class SocialUpdateUserDataErrorState extends SocialStates{}
class SocialUpdateUserDataSuccessState extends SocialStates{}
class SocialUpdateUserDataLoadingState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}
class SocialPostScreenState extends SocialStates{}

class SocialGetMeassageSuccessState extends SocialStates{}
class SocialLogoutSuccessState extends SocialStates{}
class SocialSendMeassageSuccessState extends SocialStates{}
class SocialSendMeassageErrorState extends SocialStates{
  final String error;
  SocialSendMeassageErrorState(this.error);
}
