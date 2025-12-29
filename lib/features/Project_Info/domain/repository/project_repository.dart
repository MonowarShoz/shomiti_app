import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/model/GetProjectModel.dart';
import '../../data/datasource/remote/model/get_member_assign_model.dart';

abstract class ProjectRepository{
  Future<ApiResult<List<GetProjectModel>?>> getProjectInfoData();
  Future<ApiResult<String?>> addProject({required String projectName,required String location,required int budget,required String startDate,required String fromDate});//2025-12-29
  Future<ApiResult<List<MemberAssigninfoModel>?>> getMemberAssignInfo();
  Future<ApiResult<String?>> saveMemberAssignToProject({required int projectId,required int memNo,required int amount,});
}
