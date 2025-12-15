import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_all_model.dart';
import 'package:imsomitiapp/features/Member_info/domain/provider/member_info_usecase_provider.dart';
import 'package:imsomitiapp/features/Member_info/domain/usecase/member_info_usecase.dart';

class MemberDataNotifier extends AsyncNotifier<List<MemberInfoAllModel>> {
  late MemberInfoDataUsecase memberInfoDataUsecase;
  @override
  FutureOr<List<MemberInfoAllModel>> build() async{
    memberInfoDataUsecase = await ref.read(memberInfoDataProvider.future);
    final result = await memberInfoDataUsecase.call();
    return result.when(
      success: (data) {
        return data ?? [];
      
    }, failure: (errorHandler) {
      throw errorHandler;
    },);
    
  }






}

final memberDataNotifierProvider = AsyncNotifierProvider<MemberDataNotifier, List<MemberInfoAllModel>>(
  () => MemberDataNotifier(),
);