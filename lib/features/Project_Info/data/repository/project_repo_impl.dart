import 'dart:convert';

import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/local/home_local_data_source.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/project_info_remote_src.dart';
import 'package:imsomitiapp/features/Project_Info/domain/repository/project_repository.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';

class ProjectInfoRepoImpl implements ProjectRepository{
  final ProjectInfoRemoteSrc projectInfoRemoteSrc;
  final HomeLocalDataSource localDataSource;
  ProjectInfoRepoImpl({required this.projectInfoRemoteSrc,required this.localDataSource});

  @override
  Future<ApiResult<List<GetProjectModel>?>> getProjectInfoData() async{
    try {
      final token = await localDataSource.getToken();
      final userData = await localDataSource.getUserInformation();
      if ((token?.isEmpty ?? true) && (userData?.isEmpty ?? true)) {
        return ApiResult.failure(
          ApiErrorHandler.handle(ApiErrors.unauthorizedError),
          //ApiErrorHandler.handle(ApiErrorModel(code: 401,message: 'UnAuthorized')),
        );
      }
      final Map userJson = jsonDecode(userData!);
      final result = await projectInfoRemoteSrc.getProjectInfo(token: 'Bearer $token', companyId: userJson['cid']);
      return result.when(
        success: (data) {
          if (data != null) {
            return ApiResult.success(data);
          } else {
            return ApiResult.failure(ApiErrorHandler.handle(ApiErrors.noContent));
          }
        },
        failure: (errorHandler) {
          return ApiResult.failure(ApiErrorHandler.handle(errorHandler));
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}