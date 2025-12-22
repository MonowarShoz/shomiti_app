import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/model/GetProjectModel.dart';

abstract class ProjectRepository{
  Future<ApiResult<List<GetProjectModel>?>> getProjectInfoData();
}
