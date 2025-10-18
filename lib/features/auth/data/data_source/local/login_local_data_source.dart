

abstract class LoginLocalDataSource {
  Future<void> cacheUserToken(String token);
 Future<void> cacheUserInfo(String? userData);
}
