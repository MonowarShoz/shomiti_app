import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/CrtypeModel.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/repository/kisty_repository.dart';

class CrTypeUsecase{
  final KistyRepository kistyRepository;
  CrTypeUsecase({required this.kistyRepository});

  Future<ApiResult<List<CrtypeModel>?>> call()async{
    return await kistyRepository.getCrtypeList();
  }
}