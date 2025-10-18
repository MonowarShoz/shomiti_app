import 'package:fpdart/fpdart.dart';

import 'package:imsomitiapp/core/base/base_local_data_source.dart';
import 'package:imsomitiapp/core/helper/shared_preferences_keys.dart';
import 'package:imsomitiapp/features/splash/data/datasource/local/splash_local_data_source.dart';

import '../../../../../core/helper/failure_model.dart';

class SplashLocalDataSourceImpl extends BaseLocalDataSource
    implements SplashLocalDataSource {
  SplashLocalDataSourceImpl({required super.prefs});

  @override
  Future<Either<Failure, bool>> isUserAuthenticated() async {
    try {
      final authtoken = await prefs?.getString(SharedPreferencesKeys.token);
      if (authtoken != null && authtoken.isNotEmpty) {
        
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return Left(Failure("Error ${e.toString()}"));
    }
  }
}
