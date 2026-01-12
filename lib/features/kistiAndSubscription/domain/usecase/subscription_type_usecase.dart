import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/repository/kisty_repository.dart';

import '../../data/datasource/Model/KistyTypeInfo.dart';
import '../../data/datasource/Model/get_subscription_type_model.dart';

class SubscriptionTypeUsecase{
  final KistyRepository kistyRepository;
  SubscriptionTypeUsecase({required this.kistyRepository});

  Future<ApiResult<List<GetSubscriptionTypeModel>?>> call()async{
    return await kistyRepository.getSubsctipTypeData();
  }

}