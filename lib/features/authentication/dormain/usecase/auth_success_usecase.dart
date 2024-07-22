import 'package:talkam/common/database/local/userstorage.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class AuthSuccessUsecase {
  final _userStorage = UserStorage();

  Future<void> execute(AuthSuccessResponse response) async {
    SessionManager.instance.isLoggedIn = true;
    _userStorage.saveUserToken(response.data.token);
    _userStorage.saveUser(response.data.user);
    logger.i("USER DETAILS SAVED");
    injector.get<ProfileBloc>().add(SaveUserLocallyEvent(response.data.user));
  }
}
