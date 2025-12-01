import 'package:imsomitiapp/core/base/remote_data_source.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/core/networking/api_service.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/member_info_remote_source.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_save_model.dart';

class MemberInfoRemoteSrcImpl extends BaseRemoteDataSource implements MemberInfoRemoteSource{
  MemberInfoRemoteSrcImpl({required super.apiService,required super.ref});

  @override
  Future<ApiResult<String?>> memberRegistration({required String token, required MemberInfoSaveBody memberInfoSaveBody}) {
    return safeApiCall(() async{
      return await apiService.memberRegistration(token, memberInfoSaveBody);
    },);
  }
  

}