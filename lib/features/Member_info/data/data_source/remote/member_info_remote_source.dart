import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_save_model.dart';

abstract class MemberInfoRemoteSource {
  Future<ApiResult<String?>> memberRegistration({required String token, required MemberInfoSaveBody memberInfoSaveBody});
}