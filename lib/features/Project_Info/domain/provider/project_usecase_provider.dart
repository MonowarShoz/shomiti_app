import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/Project_Info/data/provider/project_repo_data_src_provider.dart';
import 'package:imsomitiapp/features/Project_Info/domain/usecase/add_project_usecase.dart';
import 'package:imsomitiapp/features/Project_Info/domain/usecase/project_info_usecase.dart';

import '../usecase/get_member_assign_usecase.dart';
import '../usecase/save_member_project_usecase.dart';

final projectInfoDataUsecaseProvider = FutureProvider<ProjectInfoUsecase>((ref) async {
  final projectRepo = await ref.read(projectRepositoryProvider.future);
  return ProjectInfoUsecase(projectRepository: projectRepo);
});

final getMemberAssignUseCaseProvider = FutureProvider<GetMemberAssignUseCase>((ref) async {
  final projectRepo = await ref.read(projectRepositoryProvider.future);
  return GetMemberAssignUseCase(projectRepository: projectRepo);
});
final addProjectUseCaseProvider = FutureProvider<AddProjectUseCase>((ref) async {
  final projectRepo = await ref.read(projectRepositoryProvider.future);
  return AddProjectUseCase(projectRepository: projectRepo);
});
final saveMemberAssignUseCaseProvider = FutureProvider<SaveMemberProjectUseCase>((ref) async {
  final projectRepo = await ref.read(projectRepositoryProvider.future);
  return SaveMemberProjectUseCase(projectRepository: projectRepo);
});
