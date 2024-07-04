

import '../core/api/end_ponits.dart';

class GetUserModel {
  final String username;
  final String phone;
  final String email;
  final String profilePic;
  final Map<String, dynamic> location;

  GetUserModel(
      {
      required this.username,
      required this.phone,
      required this.email,
      required this.profilePic,
      required this.location});
  factory GetUserModel.fromJson(Map<String, dynamic> jsonData) {
    return GetUserModel(
        username: jsonData['user'][ApiKey.name],
        phone: jsonData['user'][ApiKey.firstname],
        email: jsonData['user'][ApiKey.email],
        profilePic: jsonData['user'][ApiKey.pic],
        location: jsonData['user'][ApiKey.location]);
  }
}
//