import 'dart:convert';

import 'package:imsomitiapp/core/networking/api_constants.dart';
import 'package:imsomitiapp/core/networking/api_error_handler.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/local/home_local_data_source.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/home_remote_data_source.dart';

import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/domain/Repository/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeLocalDataSource _localDataSource;
  final HomeRemoteDataSource _remoteDataSource;
  HomeRepoImpl(this._localDataSource,this._remoteDataSource);
  @override
  Future<ApiResult<List<MenuModel>?>> getMenuList() async{
     final token = await _localDataSource.getToken();
    final userData = await _localDataSource.getUserInformation();
     if ((token?.isEmpty ?? true) && (userData?.isEmpty ?? true)) {
      return ApiResult.failure(
        ApiErrorHandler.handle(ApiErrors.unauthorizedError),
        //ApiErrorHandler.handle(ApiErrorModel(code: 401,message: 'UnAuthorized')),
      );
    }
      final Map userJson = jsonDecode(userData!);
    final result = await _remoteDataSource.getUserMenu('Bearer $token', userJson["role"]);
    return result.when(
      success: (data) {
        if (data != null) {
          //final entityData = data.toDomain();
          return ApiResult.success(data);
        } else {
          return ApiResult.failure(ApiErrorHandler.handle(ApiErrors.noContent));
        }
      },
      failure: (errorHandler) {
        return ApiResult.failure(errorHandler);
      },
    );
    
  }
  
}