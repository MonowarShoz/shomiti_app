
import 'package:fpdart/fpdart.dart';
import 'package:imsomitiapp/core/helper/failure_model.dart';
import 'package:imsomitiapp/features/splash/domain/repository/splash_repository.dart';

class CheckUserConnectionUseCase {
  final SplashRepository _splashRepository;

  CheckUserConnectionUseCase(this._splashRepository);

  Future<Either<Failure, bool>> call() async {
    return await _splashRepository.isAuthenticated();
  }
}
