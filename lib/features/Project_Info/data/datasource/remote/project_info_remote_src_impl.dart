import 'package:imsomitiapp/core/base/remote_data_source.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/project_info_remote_src.dart';

class ProjectInfoRemoteSrcImpl extends BaseRemoteDataSource implements ProjectInfoRemoteSrc {
  ProjectInfoRemoteSrcImpl({required super.apiService, required super.ref});

  @override
  Future<ApiResult<List<GetProjectModel>?>> getProjectInfo({required String token, required int companyId}) {
    return safeApiCall(() async {
      return await apiService.getProjectData(token, companyId);
    });
  }
}
