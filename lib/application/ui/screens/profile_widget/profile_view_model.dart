import 'package:rugram/application/ui/app_view_model/app_error_catcher.dart';
import 'package:rugram/application/ui/app_view_model/app_state.dart';
import 'package:rugram/application/ui/app_view_model/app_state_notifier.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/domain/models/user/user.dart';
import 'package:rugram/domain/services/auth_service.dart';
import 'package:rugram/domain/services/user_service.dart';

class ProfileViewModel extends AppStateNotifier with AppErrorCatcher {
  ProfileViewModel(this.username) {
    setState(LoadingState());
    _init();
  }

  final _authService = AuthServiceImpl();
  final _userService = UserServiceImpl();

  final String username;

  User? _user;
  User? get user => _user;

  Future<void> _init() async {
    try {
      setState(LoadingState());
      _user ??= await _userService.fetchUserFromCache();
      if (_user != null) notifyListeners();

      await _fetchUser();
    } catch (e, stackTrace) {
      captureExcepton(
        error: e,
        stackTrace: stackTrace,
        onAuthException: (_) => logout(),
      );
    }
  }

  Future<void> _fetchUser() async {
    _user = await _userService.fetchUserFromApi(username);
    if (_user == null) return;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    AppNavigator.replaceNamed(AppRouteNames.auth);
  }
}
