import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../network/web_viewscreen.dart';
import '../cubit/cubit.dart';
import '../cubit/app_states.dart';
import 'constants.dart';


Widget DefaultButton({
  double width = double.infinity,
  double height = 40.0,
  Color background = Colors.blue,
  Color textColor = Colors.white,
  required Function onpressed,
  required String text,
  bool isUpperCase=false,
}) =>
    Container(
      width: width,
      height:height ,
      color: background,
      child: MaterialButton(
        onPressed: (){onpressed();},
        child: Center(
            child: Text(
          isUpperCase? text.toUpperCase():text,
          style: TextStyle(
            color: textColor,
            fontSize: 20.0,
          ),
        )),
      ),
    );

Widget DefaultTextField({
  required TextEditingController controller,
  required String labeltext,
   TextInputType? tybe,
  Function? onChange,
  Function? onSbubmit,
  Function? onTap,
  bool isClikable = true,
  bool isPassword = false,
  required  Function validate,
  required IconData prefix,
  IconData? sufix ,
  Function? suffiexPressed,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      enabled: isClikable,
      keyboardType: tybe,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: '$labeltext',
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(onPressed: (){suffiexPressed!();}, icon: Icon(sufix))),
      onChanged: (s){
        onChange!(s);
      },
      onFieldSubmitted: (s){
        onSbubmit!(s);
      },
      // onTap: (){
      //   onTap!();
      // },
      validator: (s) {
         validate(s);
      },
    );

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    onDismissed: (direction) {
      AppCubit.get(context).deleteDatabsae(id: model['id']);
    },
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabsae(id: model['id'], status: 'done');
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabsae(id: model['id'], status: 'archived');
              },
              icon: Icon(
                Icons.archive,
                color: Colors.grey,
              )),
        ],
      ),
    ),
  );
}

Widget conditionBuilder({
  required List<Map> tasks,
}) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => myDevider(),
        itemCount: tasks.length),
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu),
          Text(
            'No Tasks Yet, Please add a Task',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildArtivleItem(article,context)
{
  return InkWell (
    onTap: (){
      navigateTo(context, Webview(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),

            ) ,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget myDevider()=>  Padding(
  padding:  EdgeInsets.all(15.0),
  child:   Container(

    width: double.infinity,

    height: 1.0,

    color: Colors.grey[300],

  ),
);

Widget articleBuilder(list,  context)=>ConditionalBuilder(
  condition: list.length>0,
  builder:(context)=> ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArtivleItem(list[index],context),
    separatorBuilder: (context,index)=>myDevider(),
    itemCount: list.length,
  ),
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);

void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,
    )
);
void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,
    ),
    (route){
      return false;
    }
);

Widget DefaultTextButton({
   required String text,
  required Function function,
  Color color= defaultColoer,

})=>TextButton(
  onPressed: (){function();},
  child: Text(
      '${text.toUpperCase()}',style: TextStyle(color:color),
  ),
);

void showToast({
  required String msg,
  required ToastState state,

})=>Fluttertoast.showToast(
msg: msg,
toastLength: Toast.LENGTH_SHORT,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 1,
backgroundColor:chooseColor(state),
textColor: Colors.white,
fontSize: 16.0
);
enum ToastState{SUCCESS,ERROR,WARNING}

Color chooseColor(ToastState state){
  Color color;
  switch(state){
    case ToastState.SUCCESS: color=Colors.green;
    break;
    case ToastState.ERROR: color=Colors.red;
    break;
    case ToastState.WARNING:color=Colors.amber;
    break;
  }
  return color;

}
void printFullText(String text){
  final pattern=RegExp('.{1,800}');

  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
Widget buildListProduct( model,context){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                height: 120.0,
                width: 120.0,
                // fit: BoxFit.cover,
              ),
              if(model.discount !=0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white,fontSize: 12.0),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${ model.price}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: defaultColoer,
                      ),
                    ),
                    SizedBox(width: 10,),
                    if(model.discount !=0)
                      Text(
                        '${ model.oldPrice}',

                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 2,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                         // ShopCubit.get(context).changeFavorite(model.id!);

                        },
                        icon: CircleAvatar(
                          //  backgroundColor: ShopCubit.get(context).favorites[model.id]!? Colors.red:Colors.grey ,
                            radius: 15.0,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            )))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
PreferredSizeWidget defaultAppBar(
    {
      required BuildContext context,
      String? title,
      List<Widget>? actions,
    }
    ) =>AppBar(
  title: Text(title!),
  actions: actions,
  leading: IconButton(onPressed: (){
    Navigator.pop(context);
  }, icon: Icon(Icons.arrow_back_ios)),
);