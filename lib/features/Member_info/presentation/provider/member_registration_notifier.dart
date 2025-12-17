import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_error_handler.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Member_info/domain/provider/member_info_usecase_provider.dart';
import 'dart:async';

import 'package:imsomitiapp/features/Member_info/domain/usecase/member_registration_usecase.dart';

class MemberRegistrationNotifier extends AsyncNotifier<String?> {
  late MemberRegistrationUsecase memberRegistrationUsecase;

  @override
  FutureOr<String?> build() async {
    memberRegistrationUsecase = await ref.read(memberRegUsecaseProvider.future);
    return null;
  }

  Future<void> registerMember({
    required String givenName,
    String? sureName,
    required String phone,
    String? email,
    String? niD,
    String? biCNo,
    String? passportNo,
    String? nationality,
    int? gender,
    String? father,
    String? mother,
    String? address,
    String? idenDocu,
    String? photo,
  }) async {
    state = const AsyncLoading();
    final result = await memberRegistrationUsecase.call(
      givenName: givenName,
      sureName: sureName,
      email: email,
      biCNo: biCNo,
      passportNo: passportNo,
      address: address,
      father: father,
      mother: mother,

      photo: photo,
      idenDocu: idenDocu,
      gender: gender,
      niD: niD,
      nationality: nationality,
      phone: phone,
    );
    state = await result.when(
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

final memberRegistraionNotifierProvider = AsyncNotifierProvider<MemberRegistrationNotifier, String?>(() => MemberRegistrationNotifier());
