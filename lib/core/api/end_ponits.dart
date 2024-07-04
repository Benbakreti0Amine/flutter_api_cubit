class EndPoint {
  static String baseUrl = "http://127.0.0.1:8000/";
  static String signIn = "users/login/";
  static String signUp = "users/createuser/";
  static String getUser(dynamic id){
    return "user/get-user/$id";
  }
}

class ApiKey {
  static String status = "status";
  static String errorMessage = "errorMessage";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String id = "id";
  static String message = "message";
  static String name = "username";
  static String firstname = "first_name";
  static String lastname = "last_name";
  static String location = "location";
  static String pic = "profilePic";
}
//