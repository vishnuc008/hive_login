import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_login/database/dbfunctions.dart';
import 'package:hive_login/models/usermodel.dart';
import 'package:rive/rive.dart';

class signuppage extends StatelessWidget{
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  final confirmpasswordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
  body: Container(
    child: Stack(
      children: [
        RiveAnimation.asset("assets/rive/3466-7249-3d-cube-demo.riv",fit: BoxFit.cover),
        Positioned(
          top: 200,
          left: 0,
          right: 0,
          child: Column(
            children: [
              BackdropFilter(
              filter:ImageFilter.blur(sigmaX: 4,sigmaY: 10),
              child: Container(
                height: 450,
                width: 350,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.3),
                  border: Border.all(color: Colors.transparent.withOpacity(0.1),width: 2),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      style: TextStyle(color: Colors.white,fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none
                        ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      obscuringCharacter: "*",
                      controller: passwordcontroller,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                      decoration: InputDecoration(
                        hintText: "PASSWORD",
                        hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      obscureText: true,
                      obscuringCharacter: "*",
                      controller: confirmpasswordcontroller,
                      style: TextStyle(color: Colors.white,fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "CONFIRM PASSWORD",
                        hintStyle: TextStyle(color: Colors.grey[400],fontSize: 16),
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: (() {
                          validatesignup();
                        }
                        ),style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.9)),
                       child: Text("SIGNUP",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                    ),
                    SizedBox(height: 20),
                    TextButton(onPressed: (() {
                      Get.back();
                    }), child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already Have An Account?",style: TextStyle(color: Colors.grey),),
                        Text("LOGIN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                      ],
                    ))
                  ],
                ),
              ), )
            ],
          ))
      ],
    )),
   );
  }
  bool checkPassword(String pass,String confpass){
  if(pass==confpass){
    if(pass.length<6){
      Get.snackbar("Error", "Password must contain 6 characters or more",backgroundColor: Colors.white,colorText: Colors.red);
      return false;
    }else{
      return true;
    }
  }else{
    Get.snackbar("Password mismatch", "Password & confirm password are not same",colorText: Colors.red,backgroundColor: Colors.white);
    return false;
  }
}
void validatesignup()async{
final email=emailcontroller.text.trim();
final password=passwordcontroller.text.trim();
final confirmpassword=confirmpasswordcontroller.text.trim();
final isemailvalidated=EmailValidator.validate(email);
if(email!=""&& password!=""&&confirmpassword!=""){
  if(isemailvalidated==true){
    final ispasswordvalidated=checkPassword(password,confirmpassword);
    if(ispasswordvalidated==true){
      final user= UserModel(email:email,password:password);
      await dbfunctions.instance.usersignup(user);
      Get.back();
      Get.snackbar("Success", "Account Created");
      print("Success");

    }
    else{
      Get.snackbar("Error", "Please provide a valid email",colorText: Colors.red,backgroundColor: Colors.white);

    }
    
  }
  else{
    Get.snackbar("Error", "Fields can't be empty",colorText: Colors.red,backgroundColor: Colors.white);
  }
}

}
}
