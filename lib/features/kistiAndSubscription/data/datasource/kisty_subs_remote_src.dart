import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/CrtypeModel.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/KistyTypeInfo.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/data/datasource/Model/kistiInfoSaveModel.dart';

import '../../../../core/networking/api_result.dart';


abstract class KistyRemoteSrc {
  Future<ApiResult<String?>> saveKistyType({required String token, required KistiSaveModel kistiTypeBody});
  Future<ApiResult<List<CrtypeModel>?>> getCrtype({required String token});
  Future<ApiResult<List<KistyTypeInfo>?>> getKistyTypeData(String token, int companyId);
}