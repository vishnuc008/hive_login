import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_login/models/usermodel.dart';
import 'package:hive_login/screens/loginpage.dart';

void main(List<String> args)async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>("user");
  runApp(myapp());
}
class myapp extends StatelessWidget{
  myapp({super.key});
  
  @override
  Widget build(BuildContext context) {
return GetMaterialApp(
  home: loginpage(),theme: ThemeData(scaffoldBackgroundColor: Colors.grey[200]),
);
  }
}