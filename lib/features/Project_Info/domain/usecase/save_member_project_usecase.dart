import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/member_assign_model.dart';

import '../repository/project_repository.dart';

class SaveMemberProjectUseCase {
  final ProjectRepository projectRepository;

  SaveMemberProjectUseCase({required this.projectRepository});

  Future<ApiResult<String?>> call({required int id,required int projectId, required int memNo, required int amount}) async {
    return await projectRepository.saveMemberAssignToProject(id: id,projectId: projectId,memNo: memNo,amount: amount);
  }
}
