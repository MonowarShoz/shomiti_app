import 'package:imsomitiapp/core/networking/api_result.dart';

import '../repository/project_repository.dart';

class AddProjectUseCase {
  final ProjectRepository projectRepository;
  AddProjectUseCase({required this.projectRepository});

  Future<ApiResult<String?>> call({required String projectName,required String location,required int budget,required String startDate,required String fromDate})async{
    return await projectRepository.addProject(projectName: projectName, location: location, budget: budget, startDate: startDate, fromDate: fromDate);

  }

}