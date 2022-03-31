import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_layout.dart';
import 'package:socialapp/modules/social_app/social_register_screen/cubit/cubit.dart';
import 'package:socialapp/modules/social_app/social_register_screen/cubit/states.dart';

import '../../../shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    late var formKey =GlobalKey<FormState>();
    var emailcontroller=TextEditingController();
    var passwordcontroller=TextEditingController();
    var namecontroller=TextEditingController();
    var phonecontroller=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialCreateUserSuccessState){
            navigateAndFinish(context, SocialLayout());
            // if (state.shopLoginModel.status!) {
            //   print(state.shopLoginModel.status);
            //   print(state.shopLoginModel.message);
            //   print(state.shopLoginModel.data!.token);
            //   CashHelper.saveData(
            //       key: 'token', value: state.shopLoginModel.data!.token).then((
            //       value) {
            //     navigateAndFinish(context, SocialLayout());
            //   });
            // }
            //
            // else{
            //   print(state.shopLoginModel.status);
            //   print(state.shopLoginModel.message);
            //   showToast(
            //     msg: state.shopLoginModel.message!, state: ToastState.ERROR,
            //   );
            // }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title:Text('Register Now'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register now',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to communicate with your friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.name,
                          validator: (  value){
                            if(value == null ||value.isEmpty){
                              return 'must not be embty';
                            }
                          },
                          decoration: InputDecoration(
                            label: Text('Name '),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),

                          ),
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          validator: (  value){
                            if(value == null ||value.isEmpty){
                              return 'must not be embty';
                            }
                          },
                          decoration: InputDecoration(
                            label: Text('Email Address'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),

                          ),
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          controller: passwordcontroller,
                          keyboardType: TextInputType.text,
                          // onFieldSubmitted: (value){
                          //   if(formKey.currentState!.validate()){
                          //     SocialLoginCubit.get(context).userLogin(
                          //       email: emailcontroller.text,
                          //       password: passwordcontroller.text,
                          //     );
                          //   }
                          // },
                          validator: (  value){
                            if(value == null ||value.isEmpty){
                              return 'must not be embty';
                            }
                          },
                          obscureText: SocialRegisterCubit.get(context).isPasword,
                          decoration: InputDecoration(
                            label: Text('Password Address'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(onPressed: (){
                              SocialRegisterCubit.get(context).changePasswordvisibility();
                            }, icon: Icon(SocialRegisterCubit.get(context).sufix)),

                          ),
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          controller: phonecontroller,
                          keyboardType: TextInputType.phone,
                          validator: (  value){
                            if(value == null ||value.isEmpty){
                              return 'must not be embty';
                            }
                          },
                          decoration: InputDecoration(
                            label: Text('Phone Number'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),

                          ),
                        ),
                        SizedBox(height: 20.0,),
                        ConditionalBuilder(
                          condition:state is! SocialRegisterLoadingState ,
                          builder: (context)=>
                          // MaterialButton(
                          //   onPressed: (){
                          //     if(formKey.currentState!.validate()){
                          //           SocialLoginCubit.get(context).userLogin(
                          //             email: emailcontroller.text,
                          //              password: passwordcontroller.text,
                          //           );
                          //         }
                          //
                          //   },
                          //   child: Text('LOGIN'),
                          // ),
                          DefaultButton(
                            onpressed: (){
                              if(formKey.currentState!.validate()){
                                SocialRegisterCubit.get(context).userRegister(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                    name: namecontroller.text,
                                    phone: phonecontroller.text
                                );
                              }
                            },
                            text: 'Register',
                            isUpperCase: true,
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}
