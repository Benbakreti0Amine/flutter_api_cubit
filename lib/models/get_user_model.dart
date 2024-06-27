
import 'package:happy_tech_mastering_api_with_flutter/core/api/end_ponits.dart';

class GetUserModel {
  final String name;
  final String phone;
  final String email;
  final String profilePic;
  final Map<String, dynamic> location;

  GetUserModel(
      {
      required this.name,
      required this.phone,
      required this.email,
      required this.profilePic,
      required this.location});
  factory GetUserModel.fromJson(Map<String, dynamic> jsonData) {
    return GetUserModel(
        name: jsonData['user'][ApiKey.name],
        phone: jsonData['user'][ApiKey.phone],
        email: jsonData['user'][ApiKey.email],
        profilePic: jsonData['user'][ApiKey.pic],
        location: jsonData['user'][ApiKey.location]);
  }
}
//