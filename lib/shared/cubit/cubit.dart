


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../components/constants.dart';

class AppCubit extends Cubit<AppStates>
{
  int currentindex=0;
  List<Widget>screens=[


  ];
  List<String> titles=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  late Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];
  bool isBottomSheetShown=false;
  IconData fabIcon=Icons.edit;


  AppCubit() : super(AppIntialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  void ChangeIndex(int index){
    currentindex=index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase()
  {
     openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
      {
        print('database created');
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'
        ).then((value) {
          print('table created');
        } ).catchError((error){
          print('Error when crating Table ${error.toString()}');
        });
      },
      onOpen: (database){
        getDatabae(database);
        print('database opened');

      },
     ).then((value)
     {
       database=value;
       emit(AppCreateDataBaseState());
     });

  }

  insertDatabase({
    @required var title,
    @required var time,
    @required var date,
  }
      ) async {
     await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks( title, date, time, status) VALUES("$title", "$date","$time","new") '
      ).then((value) {
        print('$value inserted successfully');
        emit(AppInsertDataBaseState());
        getDatabae(database);
      }).catchError((error) {
        print('Error when inserting database: ${error.toString()}');
      });



    });
  }

   void getDatabae(database)
   {
     newTasks=[];
     doneTasks=[];
     archivedTasks=[];
     emit(AppGetDatabaseLoadingState());


      database.rawQuery('SELECT * FROM tasks').then((value)
     {

       value.forEach((element) {
          if(element['status']=='new')
            newTasks.add(element);

          else if((element['status']=='done'  ))
            doneTasks.add(element);

          else
            archivedTasks.add(element);

       });

       emit(AppGetDataBaseState());


     });
  }
  void updateDatabsae ({
  required int id,
  required String status,
}) {

    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id= ?',
        ["$status",id],
    ).then((value)
    {
      getDatabae(database);
      emit(AppUpdateDataBaseState());

      print('updated');
    });

  }
  void deleteDatabsae ({
    required int id,
  }) async{

    database.rawDelete(
      'DELETE FROM tasks  WHERE id= ?',
      [id],
    ).then((value)
    {

      emit(AppDeleteDataBaseState());
      getDatabae(database);
    });

  }

  void ChangeBottomSheetState({
  required bool isShow,
  required IconData icon,
}){
    isBottomSheetShown=isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheeteState());
  }
}