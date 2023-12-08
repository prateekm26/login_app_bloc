import 'package:loginapp/src/data_layer/models/response_models/login_response_model.dart';

abstract class ProfileState {}

class InitialState extends ProfileState {}

class LoadingUserState extends ProfileState {}

class UserLoadedSuccessState extends ProfileState {
  UserLoadedSuccessState({required this.userResponse});

  final UserResponse userResponse;
}

class UserLoadedFailedState extends ProfileState {
  UserLoadedFailedState({required this.message});

  final String message;
}
