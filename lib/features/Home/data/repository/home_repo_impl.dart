import 'dart:convert';

import 'package:imsomitiapp/core/networking/api_constants.dart';
import 'package:imsomitiapp/core/networking/api_error_handler.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/local/home_local_data_source.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/home_remote_data_source.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/child_menu_model.dart';

import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/parent_menu_model.dart';
import 'package:imsomitiapp/features/Home/domain/Repository/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeLocalDataSource _localDataSource;
  final HomeRemoteDataSource _remoteDataSource;
  HomeRepoImpl(this._localDataSource, this._remoteDataSource);
  @override
  Future<ApiResult<List<ParentMenuModel>?>> getParentMenuList() async {
    final token = await _localDataSource.getToken();
    final userData = await _localDataSource.getUserInformation();
    if ((token?.isEmpty ?? true) && (userData?.isEmpty ?? true)) {
      return ApiResult.failure(
        ApiErrorHandler.handle(ApiErrors.unauthorizedError),
        //ApiErrorHandler.handle(ApiErrorModel(code: 401,message: 'UnAuthorized')),
      );
    }
    final Map userJson = jsonDecode(userData!);
    final result = await _remoteDataSource.getParentUserMenu(
      'Bearer $token',
      userJson["cid"],
    );
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

  @override
  Future<ApiResult<List<ChildMenuModel>?>> getChildMenuList(
     {required int parentID,}
  ) async {
    final token = await _localDataSource.getToken();
    if (token?.isEmpty ?? true) {
      return ApiResult.failure(
        ApiErrorHandler.handle(ApiErrors.unauthorizedError),
        //ApiErrorHandler.handle(ApiErrorModel(code: 401,message: 'UnAuthorized')),
      );
    }
    final result = await _remoteDataSource.getChildUserMenu('Bearer $token', parentID);
    return result.when(success: (data) {
      if(data != null){
        return ApiResult.success(data);
      }else{
         return ApiResult.failure(ApiErrorHandler.handle(ApiErrors.noContent));
      }
    }, failure: (errorHandler) {
        return ApiResult.failure(errorHandler);
    },);
  }
}
