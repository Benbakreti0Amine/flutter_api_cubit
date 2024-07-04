
import '../core/api/end_ponits.dart';

class UserSignin{
  final String message;
  final String token;

  UserSignin({required this.message, required this.token});
  factory UserSignin.fromJson(Map<String,dynamic> jsonData){
    return UserSignin(message: jsonData[ApiKey.message], token: jsonData[ApiKey.token]["access"]);
  }
}//