import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/data/datasource/remote/model/member_assign_model.dart';
import 'dart:async';

import '../../../../core/networking/api_error_handler.dart';
import '../../domain/provider/project_usecase_provider.dart';
import '../../domain/usecase/save_member_project_usecase.dart';

class SaveMemberProjectNotifier extends AsyncNotifier<String?> {
  late SaveMemberProjectUseCase saveMemberProjectUseCase;

  @override
  FutureOr<String?> build() async {
    saveMemberProjectUseCase = await ref.read(saveMemberAssignUseCaseProvider.future);
    return null;
  }

  Future<void> assignMemberToProject({required int id, required int projectId, required int memNo, required int amount}) async {
    state = const AsyncLoading();
    final result = await saveMemberProjectUseCase.call(id: id, amount: amount, memNo: memNo, projectId: projectId);
    state = result.when(
      success: (data) {
        if (data != null) {
          return AsyncData(data);
        } else {
          return AsyncValue.error(ApiErrorHandler.handle("No Content"), StackTrace.current);
        }
      },
      failure: (errorHandler) {
        return AsyncValue.error(errorHandler, StackTrace.current);
      },
    );
  }
}

final memberAssignToProjectNotifierProvider = AsyncNotifierProvider<SaveMemberProjectNotifier, String?>(() => SaveMemberProjectNotifier());
