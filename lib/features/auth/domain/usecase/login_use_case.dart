
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';
import 'package:imsomitiapp/features/auth/domain/entities/user.dart';
import 'package:imsomitiapp/features/auth/domain/repository/login_repository.dart';

class LoginUseCase {
final LoginRepository loginRepository ;
LoginUseCase(this.loginRepository);


Future<ApiResult<LoginResponseModel>> call({required String username ,required String password, }) async{
  return await loginRepository.login(phone: username,password: password, );
}

}