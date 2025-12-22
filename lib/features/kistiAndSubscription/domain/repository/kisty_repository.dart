import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/kistiInfoSaveModel.dart';

import '../../data/datasource/Model/CrtypeModel.dart';
import '../../data/datasource/Model/KistyTypeInfo.dart';

abstract class KistyRepository{
  Future<ApiResult<String?>> saveKistyType({required String typeName,required int amount,required int crTypeId,required int projectId});
  Future<ApiResult<List<KistyTypeInfo>?>> getKistyTypeList();
  Future<ApiResult<List<CrtypeModel>?>> getCrtypeList();

}
