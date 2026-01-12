import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/get_subscription_type_model.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/usecase/subscription_type_usecase.dart';

import '../../data/datasource/Model/KistyTypeInfo.dart';
import '../../domain/provider/kisty_usecase_provider.dart';
import '../../domain/usecase/kisty_type_info_usecase.dart';

class SubscriptionTypeNotifier extends AsyncNotifier<List<GetSubscriptionTypeModel>> {
  late SubscriptionTypeUsecase subscriptionTypeUsecase;

  @override
  FutureOr<List<GetSubscriptionTypeModel>> build() async {
    subscriptionTypeUsecase = await ref.read(subscriptionTypeUsecaseProvider.future);
    final result = await subscriptionTypeUsecase.call();
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

final subscriptionTypeNotifierProvider = AsyncNotifierProvider<SubscriptionTypeNotifier, List<GetSubscriptionTypeModel>>(() {
  return SubscriptionTypeNotifier();
});