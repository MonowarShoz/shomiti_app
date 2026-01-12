import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/CrtypeModel.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/KistyTypeInfo.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/kistiInfoSaveModel.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/save_subscription_type_body.dart';

import '../../../../core/networking/api_result.dart';
import 'Model/get_subscription_type_model.dart';


abstract class KistyRemoteSrc {
  Future<ApiResult<String?>> saveKistyType({required String token, required KistiSaveModel kistiTypeBody});
  Future<ApiResult<List<CrtypeModel>?>> getCrtype({required String token});
  Future<ApiResult<List<KistyTypeInfo>?>> getKistyTypeData(String token, int companyId);
  Future<ApiResult<List<GetSubscriptionTypeModel>?>> getSubscriptionTypeData(String token, int companyId);
  Future<ApiResult<String?>> saveSubscriptionTypeData({required String token, required SaveSubscriptionTypeBody saveSubscriptionTypeBody});

}