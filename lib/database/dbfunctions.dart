import 'package:hive/hive.dart';
import 'package:hive_login/models/usermodel.dart';

class dbfunctions{
  dbfunctions.internal();
  static dbfunctions instance=dbfunctions.internal();
  factory dbfunctions(){
    return instance;
  }
  Future<void>usersignup(UserModel user)async{
    final db=await Hive.openBox<UserModel>("user");
    db.put(user.id, user);

  }
  Future<List<UserModel>>getUsers()async{
    final db=await Hive.openBox<UserModel>("user");
    return db.values.toList();
  }
}