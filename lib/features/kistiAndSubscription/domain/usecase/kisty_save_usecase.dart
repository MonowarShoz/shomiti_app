import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/repository/kisty_repository.dart';

class KistySaveUsecase {
  final KistyRepository kistyRepository;

  KistySaveUsecase({required this.kistyRepository});

  Future<ApiResult<String?>> call({required String typeName, required int amount, required int crTypeId, required int projectId}) async {
    return await kistyRepository.saveKistyType(typeName: typeName, amount: amount, crTypeId: crTypeId, projectId: projectId);
  }
}