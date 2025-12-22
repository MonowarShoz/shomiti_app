import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';

abstract class ProjectInfoRemoteSrc{
  Future<ApiResult<List<GetProjectModel>?>> getProjectInfo({required String token,required int companyId});
}
