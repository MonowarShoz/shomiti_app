import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'dart:async';

import '../../../../core/networking/api_error_handler.dart';
import '../../domain/provider/project_usecase_provider.dart';
import '../../domain/usecase/add_project_usecase.dart';

class ProjectAddNotifier extends AsyncNotifier<String?> {
  late AddProjectUseCase projectUseCase;

  @override
  FutureOr<String?> build() async {
    projectUseCase = await ref.read(addProjectUseCaseProvider.future);
    return null;
  }

  Future<void> addProject({
    required String projectName,
    required String location,
    required int budget,
    required String startDate,
    required String fromDate,
  }) async {
    state = const AsyncLoading();
    final result = await projectUseCase.call(projectName: projectName, location: location, budget: budget, startDate: startDate, fromDate: fromDate);
    state = result.when(
      success: (data) {
        if(data != null){
          return AsyncData(data);
        }else{
          return AsyncValue.error(ApiErrorHandler.handle("No Content"), StackTrace.current);
        }
      },
      failure: (errorHandler) {
        return AsyncValue.error(errorHandler, StackTrace.current);
      },
    );
  }
}

final projectAddNotifierProvider = AsyncNotifierProvider<ProjectAddNotifier, String?>(() => ProjectAddNotifier());
