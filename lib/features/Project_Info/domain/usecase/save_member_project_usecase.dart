import 'package:imsomitiapp/core/networking/api_result.dart';

import '../repository/project_repository.dart';

class SaveMemberProjectUseCase {
  final ProjectRepository projectRepository;
  SaveMemberProjectUseCase({required this.projectRepository});

  Future<ApiResult<String?>> call({required int projectId,required int memNo,required int amount,})async{
    return await projectRepository.saveMemberAssignToProject(projectId: projectId, memNo: memNo, amount: amount);

  }
}