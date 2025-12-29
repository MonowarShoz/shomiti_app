import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/SaveProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/member_assign_model.dart';

import 'model/get_member_assign_model.dart';

abstract class ProjectInfoRemoteSrc{
  Future<ApiResult<List<GetProjectModel>?>> getProjectInfo({required String token,required int companyId});
  Future<ApiResult<String?>> saveProject({required String token, required SaveProjectModel saveProjectBody});
  Future<ApiResult<List<MemberAssigninfoModel>?>> getMemberAssignInfo({required String token,required int companyId});
  Future<ApiResult<String?>> saveMemberAssignToProject({required String token, required MemberAssignBody memberAssignBody});

}
