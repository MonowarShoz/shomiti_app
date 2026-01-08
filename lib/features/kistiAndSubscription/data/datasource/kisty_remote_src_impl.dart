import 'package:imsomitiapp/core/base/remote_data_source.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/CrtypeModel.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/KistyTypeInfo.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/get_subscription_type_model.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/kistiInfoSaveModel.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/save_subscription_type_body.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/kisty_subs_remote_src.dart';

class KistyRemoteSrcImpl extends BaseRemoteDataSource implements KistyRemoteSrc{
  KistyRemoteSrcImpl({required super.apiService,required super.ref});
  @override
  Future<ApiResult<List<CrtypeModel>?>> getCrtype({required String token}) {
    return safeApiCall(() async{
      return await apiService.getCrtype(token);

    },);
  }

  @override
  Future<ApiResult<List<KistyTypeInfo>?>> getKistyTypeData(String token, int companyId) {
    return safeApiCall(() async{
      return await apiService.getKistypeInfo(token,companyId);

    },);
  }

  @override
  Future<ApiResult<String?>> saveKistyType({required String token, required KistiSaveModel kistiTypeBody}) {
    return safeApiCall(() async{
      return await apiService.kistiTypeSave(token,kistiTypeBody);

    },);
  }

  @override
  Future<ApiResult<List<GetSubscriptionTypeModel>?>> getSubscriptionTypeData(String token, int companyId) {
    return safeApiCall(() async{
      return await apiService.getSubsriptionType(token,companyId);

    },);
  }

  @override
  Future<ApiResult<String?>> saveSubscriptionTypeData({required String token, required SaveSubscriptionTypeBody saveSubscriptionTypeBody}) {
   return safeApiCall(() async{
     return await apiService.saveSubscriptionType(token, saveSubscriptionTypeBody);

   },);
  }

}