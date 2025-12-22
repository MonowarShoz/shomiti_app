import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/Project_Info/data/provider/project_repo_data_src_provider.dart';
import 'package:imsomitiapp/features/Project_Info/domain/usecase/project_info_usecase.dart';

final projectInfoDataUsecaseProvider = FutureProvider<ProjectInfoUsecase>((ref) async {
  final projectRepo = await ref.read(projectRepositoryProvider.future);
  return ProjectInfoUsecase(projectRepository: projectRepo);
});