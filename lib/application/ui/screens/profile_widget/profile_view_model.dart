import 'package:rugram/application/ui/app_view_model/app_error_catcher.dart';
import 'package:rugram/application/ui/app_view_model/app_state.dart';
import 'package:rugram/application/ui/app_view_model/app_state_notifier.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/domain/models/app_exception.dart';
import 'package:rugram/domain/models/post/post.dart';
import 'package:rugram/domain/models/user/user.dart';
import 'package:rugram/domain/services/auth_service.dart';
import 'package:rugram/domain/services/cache/post_service.dart';
import 'package:rugram/domain/services/cache/user_service.dart';
import 'package:rugram/domain/services/post_service.dart';
import 'package:rugram/domain/services/user_service.dart';

class ProfileViewModel extends AppStateNotifier with AppErrorCatcher {
  ProfileViewModel(String username, bool session) {
    setState(LoadingState());
    _init(username, session);
  }

  final _authService = AuthServiceImpl();
  final _userService = UserServiceImpl();
  final _cacheUserService = CacheUserServiceImpl();
  final _postService = PostServiceImpl();
  final _cachePostService = CachePostServiceImpl();

  User? _user;
  User? get user => _user;

  var _posts = <Post>[];
  List<Post> get posts => _posts;

  Future<void> _init(String username, bool session) async {
    try {
      setState(LoadingState());

      if (username.isNotEmpty) {
        await Future.wait([
          _fetchUserFromCache(username, session),
          _fetchPostsFromCache(username),
        ]);
      } else {
        await _fetchUserFromCache(username, session);
        final name = _user?.username ?? '';
        if (name.isNotEmpty) await _fetchPostsFromCache(name);
      }

      if (username.isNotEmpty) {
        await Future.wait([
          _fetchUser(username, session),
          _fetchPosts(username),
        ]);
      } else {
        await _fetchUser(username, session);
        final name = _user?.username ?? '';
        if (name.isNotEmpty) await _fetchPosts(name);
      }

      setState(InitialAppState());
    } catch (e, stackTrace) {
      setStateByException(e);
      captureExcepton(
        error: e,
        stackTrace: stackTrace,
        onAuthException: (_) => logout(),
      );
    }
  }

  Future<void> _fetchPostsFromCache(String username) async {
    _posts = await _cachePostService.getAllPosts(username);
    if (_posts.isEmpty) return;
    notifyListeners();
  }

  Future<void> _fetchPosts(String username) async {
    _posts = await _postService.getAllPosts(username);
    if (_posts.isEmpty) return;
    notifyListeners();
  }

  Future<void> _fetchUserFromCache(String username, bool session) async {
    if (username.isEmpty && session) {
      _user = await _cacheUserService.getUserFromSession();
    } else if (username.isNotEmpty) {
      _user = await _userService.getUser(username);
    }
    if (_user == null) return;
    notifyListeners();
  }

  Future<void> _fetchUser(String username, bool session) async {
    if (username.isEmpty && session) {
      _user = await _userService.getUserFromSession();
    } else if (username.isNotEmpty) {
      _user = await _userService.getUser(username);
    } else {
      throw ApiException(type: ApiExceptionType.badRequest);
    }

    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    AppNavigator.replaceNamed(AppRouteNames.auth);
  }
}
