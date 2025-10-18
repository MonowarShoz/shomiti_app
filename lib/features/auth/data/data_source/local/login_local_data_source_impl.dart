import 'package:imsomitiapp/core/base/base_local_data_source.dart';
import 'package:imsomitiapp/core/helper/shared_pref_helper.dart';
import 'package:imsomitiapp/features/auth/data/data_source/local/login_local_data_source.dart';

class LoginLocalDataSourceImpl extends BaseLocalDataSource
    implements LoginLocalDataSource {
  LoginLocalDataSourceImpl({
    required SharedPrefHelper prefs,
    
  }) : super(prefs: prefs);

  @override
  Future<void> cacheUserToken(String? token) async {
    if (token != null) {
      await storeToken(token);
     
    }
  }
  
  @override
  Future<void> cacheUserInfo(String? userData) async{
    if(userData != null){
      await storeUserInfo(userData);
    }
  }
}