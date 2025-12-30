import '../../../../core/networking/api_result.dart';
import '../../data/datasource/remote/model/get_member_assign_model.dart';
import '../repository/project_repository.dart';

class GetMemberAssignUseCase {
  final ProjectRepository projectRepository;
  GetMemberAssignUseCase({required this.projectRepository});

  Future<ApiResult<List<MemberAssigninfoModel>?>> call()async{
    return await projectRepository.getMemberAssignInfo();

  }

}