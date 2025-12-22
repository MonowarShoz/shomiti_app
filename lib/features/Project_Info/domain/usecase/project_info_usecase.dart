import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/domain/repository/project_repository.dart';

class ProjectInfoUsecase {
  final ProjectRepository projectRepository;

  ProjectInfoUsecase({required this.projectRepository});

  Future<ApiResult<List<GetProjectModel>?>> call() async {
    return await projectRepository.getProjectInfoData();
  }
}
