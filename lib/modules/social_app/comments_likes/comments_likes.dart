import 'package:flutter/material.dart';
import 'package:socialapp/shared/components/components.dart';

class CommentScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment and Likes page'),
      ),
      body: Column(
        children: [
         Expanded(
           child: ListView.separated(
               itemBuilder: (context, index) => commentItem(context),
               separatorBuilder: (context, index) => myDevider(),
               itemCount: 10
           )
         ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(

                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?size=626&ext=jpg&uid=R67026870&ga=GA1.2.1158322374.1647774025'
                  ),
                  radius: 18.0,
                ),
                SizedBox(width: 20.0,),
                Flexible(
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        // border: OutlineInputBorder()
                          hintText: 'Write Your Comment..',
                        suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.send))
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget commentItem(context)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      children: [
        CircleAvatar(

          backgroundImage: NetworkImage(
              'https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?size=626&ext=jpg&uid=R67026870&ga=GA1.2.1158322374.1647774025'
          ),
          radius: 25.0,
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'AbdulAziz Diab',
                    style: TextStyle(height: 1.4,fontWeight: FontWeight.bold),
                  ),

                ],
              ),
              Text('That is my comment',style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4)),

            ],
          ),
        ),
      ],
    ),
  );
}
