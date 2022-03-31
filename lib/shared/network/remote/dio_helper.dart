import 'package:dio/dio.dart';

class DioHelper{

  static late Dio dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/' ,
        receiveDataWhenStatusError: true,

      )
    );
  }

  static Future<Response> getData({
    String lang='en',
    String? token,
  required String url,
     Map<String,dynamic>? queries,
}) async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',

    };
    return await dio.get(url,queryParameters: queries);
  }

  static Future<Response> postData({
    required String url,
     Map<String,dynamic>?queries,
    String lang='en',
    String? token,
    required Map<String,dynamic>data,
}) async {
    dio.options.headers={
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return dio.post(
      url,
      data: data,
      queryParameters: queries,
    );
  }
  static Future<Response> putData({
    required String url,
    Map<String,dynamic>?queries,
    String lang='en',
    String? token,
    required Map<String,dynamic>data,
  }) async {
    dio.options.headers={
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return dio.put(
      url,
      data: data,
      queryParameters: queries,
    );
  }

}