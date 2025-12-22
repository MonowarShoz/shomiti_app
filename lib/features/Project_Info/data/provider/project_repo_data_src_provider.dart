import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/features/Home/data/provider/home_data_provider.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/project_info_remote_src.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/project_info_remote_src_impl.dart';
import 'package:imsomitiapp/features/Project_Info/data/repository/project_repo_impl.dart';
import 'package:imsomitiapp/features/Project_Info/domain/repository/project_repository.dart';

final projectRepoDataSrcProvider = FutureProvider<ProjectInfoRemoteSrc>((ref) async{
  final apiService = await ref.read(apiServiceProvider.future);
  return ProjectInfoRemoteSrcImpl(apiService: apiService, ref: ref);

},);

final projectRepositoryProvider = FutureProvider<ProjectRepository>((ref) async{
  final projectRemoteSrc = await ref.read(projectRepoDataSrcProvider.future);
  final localDataSrc = await ref.read(homelocalDataSourceProvider.future);
  return ProjectInfoRepoImpl(projectInfoRemoteSrc: projectRemoteSrc, localDataSource: localDataSrc);

},);