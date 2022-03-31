
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/cubit/app_states.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit( ) : super(NewsAppIntialState());
  bool isDark=false;
  static AppCubit get(context)=>BlocProvider.of(context);

  void changeAppMode({fromshared}){
    if(fromshared != null) {
      isDark = fromshared;
      emit(NewsAppChangeModeState());

    }
    else {
      isDark = !isDark;

      CashHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsAppChangeModeState());
      });
    }
  }
}

//https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=fa0539f17b944fdeb95ec3a182c6c169