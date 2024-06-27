import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/cache/cachehelper.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_consumer.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/end_ponits.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/errors/exceptions.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/get_user_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/models/user_signin_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/user_signup_model.dart';

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
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpLocation = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  UserSignin? user;
  GetUserModel? user1;
  uploadImage(XFile image) {
    profilePic = image;
    emit(ImageUploaded());
  }

  signUp() async {
    try {
      print("================================");
      print(signUpEmail.text);
      emit(SignUpLoading());
      final response = await api.post(
        EndPoint.signUp,
        isFromData: true,
        data: {
          ApiKey.name: signUpName.text,
          ApiKey.phone: signUpPhoneNumber.text,
          ApiKey.email: signUpEmail.text,
          ApiKey.password: signUpPassword.text,
          ApiKey.confirmpass: confirmPassword.text,
          ApiKey.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKey.pic: await uploadImage(profilePic!)
        },
      );
      final signUPModel = UserSignup.fromJson(response);
      emit(SignUpSuccess(message: signUPModel.message));
    } on ServerException catch (e) {
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
        ApiKey.email: signInEmail.text,
        ApiKey.password: signInPassword.text,
      });
      user = UserSignin.fromJson(response);

      try {
        final decodedToken = JwtDecoder.decode(user!.token);
        CacheHelper().saveData(key: ApiKey.token, value: user!.token);
        CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
        print(decodedToken[ApiKey.id]);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure(errMessage: 'Invalid JWT token format'));
      }
    } on ServerException catch (e) {
      emit(SignInFailure(errMessage: e.errModel.errorMessage));
    }
  }

  void getUserProfile() {}
}
//