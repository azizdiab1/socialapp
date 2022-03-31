// https://newsapi.org/
// v2/everything?q=tesla&
// apiKey=fa0539f17b944deb95ec3a182c6c169


import 'package:flutter/material.dart';

import '../network/local/cash_helper.dart';
import 'components.dart';

const defaultColoer=Colors.blue;

void logOut(context){
CashHelper.removeData(key: 'token').then((value) {
if(value){
// navigateAndFinish(context, ShopLoginScreen());

}
});
}
String? uId=CashHelper.get(key: 'uId');

// String? uId;