
import '../core/api/end_ponits.dart';

class UserSignup {
  final String message;

  UserSignup({required this.message});

  factory UserSignup.fromJson(Map <String,dynamic> jsonData){
    return UserSignup(message: jsonData[ApiKey.message]);
  }
}//