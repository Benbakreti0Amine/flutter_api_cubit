import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../cache/cachehelper.dart';
import '../core/api/api_consumer.dart';
import '../core/api/end_ponits.dart';
import '../core/errors/exceptions.dart';
import '../models/get_user_model.dart';
import '../models/user_signin_model.dart';
import '../models/user_signup_model.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();

  TextEditingController signUpLastname = TextEditingController();
  TextEditingController signUpFirstname = TextEditingController();

  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpLocation = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();

  UserSignin? user;
  GetUserModel? user1;
  uploadImage(XFile image) {
    profilePic = image;
    emit(ImageUploaded());
  }

  signUp() async {
    try {
      emit(SignUpLoading());
      final response = await api.post(
        EndPoint.signUp,
        isFromData: true,
        data: {
          // ApiKey.name: signUpName.text,
          // ApiKey.firstname: signUpFirstname.text,
          // ApiKey.lastname: signUpLastname.text,
          // ApiKey.email: signUpEmail.text,
          // ApiKey.password: signUpPassword.text,
          // ApiKey.pic: await uploadImage(profilePic!)
          "username": "dev",
          "password": "123",
          "email": "dev@example.com",
          "first_name": "moh",
          "last_name": "ben"
        },
      );
      final signUPModel = UserSignup.fromJson(response);
      emit(SignUpSuccess(message: signUPModel.message));
    } on ServerException catch (e) {
      print("========================");
      print(e.errModel.errorMessage);
      print("========================");
      emit(SignUpFailure(errMessage: e.errModel.errorMessage));
    } 
  }

  getUserData() async {
    emit(GetprofileLoading());
    try {
      print("======================");
      print(EndPoint.getUser(CacheHelper().getData(key: ApiKey.id)));
      final response = await api.get(
        EndPoint.getUser(CacheHelper().getData(key: ApiKey.id)),
      );

      emit(GetProfilesuccess(user: GetUserModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(GetprofileFailed(errMessage: e.errModel.errorMessage));
    }
  }

  signIn() async {
    emit(SignInLoading());
    try {
      final response = await api.post(EndPoint.signIn, data: {
        // ApiKey.email: signInEmail.text,
        // ApiKey.password: signInPassword.text,
        "email": "m.benbakreti@esi-sba.dz",
        "password": "1234",
      });
      // print(response);
      // print("=====================================");
      user = UserSignin.fromJson(response);

      try {
        final decodedToken = JwtDecoder.decode(user!.token);
        CacheHelper().saveData(key: ApiKey.token, value: user!.token);
        CacheHelper().saveData(key: ApiKey.id, value: decodedToken["user_id"]);
        print(decodedToken["user_id"]);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure(errMessage: 'Invalid JWT token format'));
      }
    } on ServerException catch (e) {
      print("===============================");
      print(e.errModel.errorMessage);
      print("===============================");

      emit(SignInFailure(errMessage: e.errModel.errorMessage));
    }
  }

  void getUserProfile() {}
}
//
