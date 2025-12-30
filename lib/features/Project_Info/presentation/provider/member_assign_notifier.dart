import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Project_Info/domain/provider/project_usecase_provider.dart';
import 'dart:async';

import '../../data/datasource/remote/model/get_member_assign_model.dart';
import '../../domain/usecase/get_member_assign_usecase.dart';

class MemberAssignNotifier extends AsyncNotifier<List<MemberAssigninfoModel>> {
  late GetMemberAssignUseCase getMemberAssignUseCase;
  @override
  FutureOr<List<MemberAssigninfoModel>> build() async {
    getMemberAssignUseCase = await ref.read(getMemberAssignUseCaseProvider.future);
    final result = await getMemberAssignUseCase.call();
    return result.when(
      success: (data) {
        return data ?? [];
      },
      failure: (errorHandler) => throw errorHandler,
    );
  }
}

final memberAssignNotifierProvider = AsyncNotifierProvider<MemberAssignNotifier, List<MemberAssigninfoModel>>(() => MemberAssignNotifier());
