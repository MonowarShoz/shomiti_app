import 'dart:convert';

import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/local/home_local_data_source.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/SaveProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/get_member_assign_model.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/project_info_remote_src.dart';
import 'package:imsomitiapp/features/Project_Info/domain/repository/project_repository.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../datasource/remote/model/member_assign_model.dart';

class ProjectInfoRepoImpl implements ProjectRepository {
  final ProjectInfoRemoteSrc projectInfoRemoteSrc;
  final HomeLocalDataSource localDataSource;

  ProjectInfoRepoImpl({required this.projectInfoRemoteSrc, required this.localDataSource});

  @override
  Future<ApiResult<List<GetProjectModel>?>> getProjectInfoData() async {
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

  @override
  Future<ApiResult<String?>> addProject({
    required String projectName,
    required String location,
    required int budget,
    required String startDate,
    required String fromDate,
  }) async {
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
      final result = await projectInfoRemoteSrc.saveProject(
        token: 'Bearer $token',
        saveProjectBody: SaveProjectModel(
          projectId: 0,
          id: 0,
          compId: userJson['cid'],
          projectName: projectName,
          proLocation: location,
          diretorId: 0,

          budget: budget,
          startDate: startDate,
          tentitiveEndDate: fromDate,
        ),
      );
      return result.when(
        success: (data) {
          if (data != null) {
            return ApiResult.success(data);
          } else {
            return ApiResult.failure(ApiErrorHandler.handle('No Content'));
          }
        },
        failure: (errorHandler) {
          return ApiResult.failure(errorHandler);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<MemberAssigninfoModel>?>> getMemberAssignInfo() async {
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
      final result = await projectInfoRemoteSrc.getMemberAssignInfo(token: 'Bearer $token', companyId: userJson['cid']);
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

  @override
  Future<ApiResult<String?>> saveMemberAssignToProject({required int id,required int projectId, required int memNo, required int amount}) async {
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
      final result = await projectInfoRemoteSrc.saveMemberAssignToProject(
        token: 'Bearer $token',
        memberAssignBody: MemberAssignBody(
          id: id,
          amount: amount,
          memNo: memNo,
          assignBy: userJson['username'],
          compId: userJson['cid'],
          projectId: projectId,
        ),
      );
      return result.when(success: (data) {
        if (data != null) {
          return ApiResult.success(data);
        } else {
          return ApiResult.failure(ApiErrorHandler.handle('No Content'));
        }
      }, failure: (errorHandler) {
        return ApiResult.failure(ApiErrorHandler.handle(errorHandler));

      },);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
