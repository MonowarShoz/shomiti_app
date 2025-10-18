import 'package:fpdart/fpdart.dart';

import '../../../../../core/helper/failure_model.dart';


abstract class SplashLocalDataSource {
  Future<Either<Failure,bool>> isUserAuthenticated();
}