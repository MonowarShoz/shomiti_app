import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/kistiInfoSaveModel.dart';

import '../../data/datasource/Model/CrtypeModel.dart';
import '../../data/datasource/Model/KistyTypeInfo.dart';
import '../../data/datasource/Model/get_subscription_type_model.dart';

abstract class KistyRepository{
  Future<ApiResult<String?>> saveKistyType({required int id,required String typeName,required int amount,required int crTypeId,required int projectId});
  Future<ApiResult<List<KistyTypeInfo>?>> getKistyTypeList();
  Future<ApiResult<List<CrtypeModel>?>> getCrtypeList();
  Future<ApiResult<String?>>  addSubsctiptionType({required int id,required int crTypeId, required String typeName,required int projectId, required int amount});
  Future<ApiResult<List<GetSubscriptionTypeModel>?>> getSubsctipTypeData();

}
