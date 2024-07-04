
import '../models/get_user_model.dart';

class UserState {}

final class UserInitial extends UserState {}


final class SignInSuccess extends UserState {}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}
final class SignUpSuccess extends UserState {
  final String message;

  SignUpSuccess({required this.message});
}

final class SignUpLoading extends UserState {}

final class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}
final class ImageUploaded extends UserState{}
final class GetProfilesuccess extends UserState{
  final GetUserModel user;

  GetProfilesuccess({required this.user});
  //
}
final class GetprofileFailed extends UserState{
  final String errMessage;
  GetprofileFailed({required this.errMessage});
}
final class GetprofileLoading extends UserState{}
//
