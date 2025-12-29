import 'package:imsomitiapp/core/base/remote_data_source.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/SaveProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/get_member_assign_model.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/member_assign_model.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/project_info_remote_src.dart';

class ProjectInfoRemoteSrcImpl extends BaseRemoteDataSource implements ProjectInfoRemoteSrc {
  ProjectInfoRemoteSrcImpl({required super.apiService, required super.ref});

  @override
  Future<ApiResult<List<GetProjectModel>?>> getProjectInfo({required String token, required int companyId}) {
    return safeApiCall(() async {
      return await apiService.getProjectData(token, companyId);
    });
  }

  @override
  Future<ApiResult<String?>> saveProject({required String token, required SaveProjectModel saveProjectBody}) {
    return safeApiCall(() async {
      return await apiService.saveProject(token, saveProjectBody);
    });
  }

  @override
  Future<ApiResult<List<MemberAssigninfoModel>?>> getMemberAssignInfo({required String token, required int companyId}) {
   return safeApiCall(() async{
     return await apiService.getMemberAssign(token, companyId);

   },);
  }

  @override
  Future<ApiResult<String?>> saveMemberAssignToProject({required String token, required MemberAssignBody memberAssignBody}) {
    return safeApiCall(() async{
      return await apiService.memberAssign(token, memberAssignBody);

    },);
  }
}
