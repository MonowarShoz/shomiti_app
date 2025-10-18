import 'package:fpdart/fpdart.dart';
import 'package:imsomitiapp/features/splash/data/datasource/local/splash_local_data_source.dart';

import 'package:imsomitiapp/features/splash/domain/repository/splash_repository.dart';

import '../../../../core/helper/failure_model.dart';

class SplashRepositoryImplementation implements SplashRepository {
  final SplashLocalDataSource _localDataSource;

  SplashRepositoryImplementation(this._localDataSource);

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    return await _localDataSource.isUserAuthenticated();
  }
}
