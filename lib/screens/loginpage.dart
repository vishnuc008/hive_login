import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive_login/database/dbfunctions.dart';
import 'package:hive_login/models/usermodel.dart';
import 'package:hive_login/screens/homescreen.dart';
import 'package:hive_login/screens/signup.dart';
import 'package:rive/rive.dart';

class loginpage extends StatelessWidget{
  loginpage({super.key});
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
  body: Container(
    child: Stack(
      children: [
        RiveAnimation.asset("assets/rive/3466-7249-3d-cube-demo.riv",fit: BoxFit.cover,),
        Positioned(
          top: 200,
          left: 0,
          right: 0,
         child: Column(
          children: [
            BackdropFilter(filter:ImageFilter.blur(sigmaX: 2,sigmaY: 4),
            child: Container(
              height: 400,width: 350,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.3),
                border: Border.all(
                  color: Colors.transparent.withOpacity(0.1),width: 2
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  TextField(
                    controller: emailcontroller,
                    style: TextStyle(color: Colors.white,fontSize: 18),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    controller: passwordcontroller,
                    style: TextStyle(color: Colors.white,fontSize: 18),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: (() async{
                        final list= 
                        await dbfunctions.instance.getUsers();
                        checkUser(list);
                      }
                      ),style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.9),
                      ), child: Text("LOGIN",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                  SizedBox(height: 20),
                  TextButton(onPressed: (() {
                    Get.to(
                      ()=>signuppage(),transition: Transition.leftToRightWithFade,
                    );
                  }), child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't Have An Account ?",style: TextStyle(color: Colors.grey),),
                      Text("SIGNUP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                    ],
                  ))
                ],
              ),
              ),)
          ],
         ))
      ],
    ),),
   );
  }
  Future<void>checkUser(List<UserModel>userlist)async{
  final email=emailcontroller.text.trim();
  final password=passwordcontroller.text.trim();
  bool isuserfound=false;
  final isvalidated=await validatelogin(email,password);
  if(isvalidated==true){
    await Future.forEach(userlist, (user) {
      if (user.email==email&& user.password==password){
        isuserfound=true;
      }else{
        isuserfound=false;
      }
    });
    if(isuserfound=true){
      Get.offAll(()=>homescreen(email: email));
      Get.snackbar("Success", "Logged in as $email");
    }else{
      Get.snackbar("Error", "Incorrect password or email",colorText: Colors.red,backgroundColor: Colors.white);
    }
  }else{
    Get.snackbar("Error", "Fields cannot be empty",colorText: Colors.red,backgroundColor: Colors.white);
  }
  }
  Future<bool>validatelogin(String email,String password)async{
   if(email!=""&& password!=""){
    return true;
   }else{
    return false;
   }
  }


}
