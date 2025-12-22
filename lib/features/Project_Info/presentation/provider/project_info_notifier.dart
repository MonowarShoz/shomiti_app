import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/GetProjectModel.dart';
import 'package:imsomitiapp/features/Project_Info/domain/usecase/project_info_usecase.dart';

import '../../domain/provider/project_usecase_provider.dart';

class ProjectInfoNotifier extends AsyncNotifier<List<GetProjectModel>?> {
  late ProjectInfoUsecase projectInfoUsecase;

  @override
  FutureOr<List<GetProjectModel>?> build() async {
    projectInfoUsecase = await ref.read(projectInfoDataUsecaseProvider.future);
    final result = await projectInfoUsecase.call();
    return result.when(
      success: (data) {
        return data ?? [];
      },
      failure: (errorHandler) {
        throw errorHandler;
      },
    );
  }
}

final projectInfoNotifierProvider = AsyncNotifierProvider<ProjectInfoNotifier, List<GetProjectModel>?>(() {
  return ProjectInfoNotifier();
});
