import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp/src/business_layer/blocs/profile/profile_state.dart';
import 'package:loginapp/src/business_layer/localization/app_localizations.dart';
import 'package:loginapp/src/data_layer/local_db/user_state_hive_helper.dart';

/// The [ProfileBloc] class extends [Cubit<UserState>] and is responsible for
/// managing the state of the user-related data in the application.
class ProfileBloc extends Cubit<ProfileState> {
  /// Initializes the UserBloc with an initial state of [InitialState].
  ProfileBloc() : super(InitialState());

  /// Asynchronously fetches user details and updates the state accordingly.
  /// This method triggers an asynchronous operation to fetch user details.
  /// It updates the state to [LoadingUserState] while the operation is in
  /// progress. Once the operation is complete, it updates the state to
  /// [UserLoadedSuccessState] if the response is successful or
  /// [UserLoadedFailedState] if an error occurs.
  Future<void> fetchUserDetail() async {
    emit(LoadingUserState());
    final response = await UserStateHiveHelper.instance.getUserResponse();
    if (response != null) {
      emit(UserLoadedSuccessState(
        userResponse: response,
      ));
    } else {
      emit(UserLoadedFailedState(
        message: AppLocalizations.current.parseExceptionMessage,
      ));
    }
  }
}
