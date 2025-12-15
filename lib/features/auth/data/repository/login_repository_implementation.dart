import 'dart:convert';

import 'package:imsomitiapp/core/networking/api_constants.dart';
import 'package:imsomitiapp/core/networking/api_error_handler.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/auth/data/data_source/local/login_local_data_source.dart';
import 'package:imsomitiapp/features/auth/data/data_source/mappers/user_data_mapper.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/login_remote_dt_src.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';
import 'package:imsomitiapp/features/auth/domain/entities/user.dart';
import 'package:imsomitiapp/features/auth/domain/repository/login_repository.dart';

class LoginRepositoryImplementation implements LoginRepository {
  final LoginLocalDataSource _loginLocalDataSource;
  final LoginRemoteDataSource _loginRemoteDataSource;
  LoginRepositoryImplementation(this._loginLocalDataSource, this._loginRemoteDataSource);
  @override
  Future<ApiResult<LoginResponseModel>> login({required String phone, required String password, String? deviceToken}) async {
    try {
      final result = await _loginRemoteDataSource.login(username: phone, password: password,);

      return result.when(
        success: (loginResponseData) async {
          if (loginResponseData != null) {
            final user = loginResponseData;
            final userData = jsonEncode(user);
            await _loginLocalDataSource.cacheUserInfo(userData);
            await _loginLocalDataSource.cacheUserToken(user!.token!);

            return ApiResult.success(user);
          } else {
            return ApiResult.failure(ApiErrorHandler.handle(DataSource.noContent.getFailure()));
          }
        },
        failure: (errorHandler) {
          return ApiResult.failure(errorHandler);
        },
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // @override
  // Future<ApiResult<String?>> changePassword({required String phone, required String currpassword, required String newpass}) async {
  //   try {
  //     final result = await _loginRemoteDataSource.changePass(phone: phone, currentpass: currpassword, newpass: newpass);

  //     return result.when(
  //       success: (data) async {
  //         if (data != null) {
  //           return ApiResult.success(data);
  //         } else {
  //           return ApiResult.failure(ApiErrorHandler.handle(ApiErrors.noContent));
  //         }
  //       },
  //       failure: (errorHandler) {
  //         return ApiResult.failure(errorHandler);
  //       },
  //     );
  //   } catch (error) {
  //     return ApiResult.failure(ApiErrorHandler.handle(error));
  //   }
  // }
}
