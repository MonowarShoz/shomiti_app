import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/repository/kisty_repository.dart';

import '../../data/datasource/Model/KistyTypeInfo.dart';

class KistyTypeInfoUsecase{
  final KistyRepository kistyRepository;
  KistyTypeInfoUsecase({required this.kistyRepository});

  Future<ApiResult<List<KistyTypeInfo>?>> call()async{
    return await kistyRepository.getKistyTypeList();
  }

}

