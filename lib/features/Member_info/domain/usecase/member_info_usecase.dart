import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_all_model.dart';
import 'package:imsomitiapp/features/Member_info/domain/repository/member_info_repository.dart';

class MemberInfoDataUsecase {
  final MemberInfoRepository repository;
  MemberInfoDataUsecase({required this.repository});

  Future<ApiResult<List<MemberInfoAllModel>?>> call() async {
    return await repository.getAllMemberData();
  }

}