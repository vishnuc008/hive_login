import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homescreen extends StatelessWidget{
  homescreen({super.key,required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(title: Text("welcome $email")),
   );
  }

}