import 'package:fpdart/fpdart.dart';

import '../../../../core/helper/failure_model.dart';


abstract class SplashRepository {
  Future<Either<Failure, bool>> isAuthenticated();
}
