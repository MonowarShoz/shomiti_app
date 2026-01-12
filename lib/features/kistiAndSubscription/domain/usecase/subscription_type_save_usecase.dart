import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/repository/kisty_repository.dart';

import '../../data/datasource/Model/KistyTypeInfo.dart';

class SubscriptionTypeSaveUsecase{
  final KistyRepository kistyRepository;
  SubscriptionTypeSaveUsecase({required this.kistyRepository});

  Future<ApiResult<String?>> call({required int id,required String typeName, required int amount, required int crTypeId, required int projectId}) async {
    return await kistyRepository.addSubsctiptionType(id: id,typeName: typeName, amount: amount, crTypeId: crTypeId, projectId: projectId);
  }

}