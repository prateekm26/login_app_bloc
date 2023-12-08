import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp/src/business_layer/blocs/profile/profile_bloc.dart';
import 'package:loginapp/src/business_layer/blocs/profile/profile_state.dart';
import 'package:loginapp/src/business_layer/localization/app_localizations.dart';
import 'package:loginapp/src/business_layer/util/helper/screen_navigation_helper.dart';
import 'package:loginapp/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:loginapp/src/data_layer/models/response_models/login_response_model.dart';
import 'package:loginapp/src/data_layer/res/styles.dart';
import 'package:loginapp/src/ui_layer/screens/login_screen.dart';
import 'package:loginapp/src/ui_layer/widgets/app_buttons.dart';
import 'package:loginapp/src/ui_layer/widgets/appbar_widget.dart';
import 'package:loginapp/src/ui_layer/widgets/network_image_widget.dart';
import 'package:loginapp/src/ui_layer/widgets/progress_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().fetchUserDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.current.profileScreen,
        ),
        body: SafeArea(child: _mainWidget(context)),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: CommonAppButton(
                title: AppLocalizations.current.logout,
                onPressed: logout,
              ),
            ),
          ],
        ));
  }

  Widget _mainWidget(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is LoadingUserState) {
          return const ProgressBar(opacity: 0);
        } else if (state is UserLoadedSuccessState) {
          return SingleChildScrollView(
            padding: AppStyles.pd20,
            child: _scrollWidget(state.userResponse),
          );
        } else if (state is UserLoadedFailedState) {
          return Text(
            state.message,
            style: AppStyles.mainNormal14,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _scrollWidget(UserResponse userResponse) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              height: 100,
              child: NetworkImageWidget(
                url: userResponse.profileImage,
              ),
            ),
          ),
        ),
        AppStyles.sbHeight20,
        _rowItem(AppLocalizations.current.name, userResponse.userName),
        const Divider(),
        _rowItem(AppLocalizations.current.mobileNumber, userResponse.mobileNo),
        const Divider(),
        _rowItem(
            AppLocalizations.current.dateOfBirth, userResponse.dateOfBirth),
        const Divider(),
        _rowItem(
            AppLocalizations.current.designation, userResponse.designation),
        const Divider(),
        _rowItem(AppLocalizations.current.memberType, userResponse.memberType),
        const Divider(),
        _rowItem(AppLocalizations.current.firmName, userResponse.firmName),
        const Divider(),
        _rowItem(AppLocalizations.current.address, userResponse.address),
        AppStyles.sbHeight10,
      ],
    );
  }

  Widget _rowItem(String title, String? value) {
    return Padding(
      padding: AppStyles.pdV6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppStyles.mainBold14,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "",
              textAlign: TextAlign.start,
              style: AppStyles.mainNormal14,
            ),
          ),
        ],
      ),
    );
  }

  /// handle logout button tap
  void logout() {
    UserStateHiveHelper.instance.logOut();
    Navigator.pushAndRemoveUntil(
      context,
      ScreenNavigation.createRoute(widget: const LoginScreen()),
      (route) => false,
    );
  }
}
