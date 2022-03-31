import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_app/social_layout.dart';
import 'package:socialapp/modules/social_app/social_login_screen/cubit/social_login_cubit.dart';
import 'package:socialapp/modules/social_app/social_login_screen/cubit/social_login_states.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';

import '../../../shared/components/constants.dart';
import '../social_register_screen/social_register_screen.dart';

class SocialLoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    late var formKey =GlobalKey<FormState>();
    var emailcontroller=TextEditingController();
    var passwordcontroller=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
          listener:(context, state) {
            if(state is SocialLoginErrorState){
              showToast(msg: state.error, state: ToastState.ERROR);
            }
            if (state is SocialLoginSuccessState){
              CashHelper.saveData(key: 'uId', value: state.uId).then((value) {
                navigateAndFinish(context,SocialLayout());
              });
            }
          },
          builder:(context, state) {
            return Scaffold(
              appBar: AppBar(),
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
                              'LOGIN',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                              fontSize: 28.0
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Text(
                              'Login now to communicate with your friends',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,

                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'must not be embty';
                              }
                            },
                            decoration: const InputDecoration(
                              label: Text('Email Address'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),

                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            controller: passwordcontroller,
                            keyboardType: TextInputType.text,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'must not be embty';
                              }
                            },
                            obscureText: SocialLoginCubit.get(context).isPassword,
                            decoration:  InputDecoration(
                              label: Text('Password'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    SocialLoginCubit.get(context).changePasswordVisibility();
                                    },
                                  icon: Icon(SocialLoginCubit.get(context).passwordSufixIcon),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          ConditionalBuilder(
                              condition: state is !SocialLoginLoadingState,
                              builder: (context)=>DefaultButton(
                                  onpressed: (){
                                    if(formKey.currentState!.validate()){
                                      SocialLoginCubit.get(context).userLogin(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text,
                                      );
                                    }
                                  },
                                  text: 'LOGIN',
                                isUpperCase: true,

                              ),
                              fallback: (context)=>Center(child: CircularProgressIndicator()),
                          ),
                          IconButton(onPressed: (){print('This is $uId');}, icon: Icon(Icons.add)),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'Don\'t have account? '
                              ),
                              DefaultTextButton(color:defaultColoer,text: 'register now', function: (){
                                navigateTo(context, SocialRegisterScreen());
                              })
                            ],
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
