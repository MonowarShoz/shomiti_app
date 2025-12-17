import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Member_info/domain/repository/member_info_repository.dart';

class MemberRegistrationUsecase {
  final MemberInfoRepository repository;
  MemberRegistrationUsecase({required this.repository});

  Future<ApiResult<String?>> call({
    required String givenName,
    String? sureName,
    required String phone,
    String? email,
    String? niD,
    String? biCNo,
    String? passportNo,
    String? nationality,
    int? gender,
    String? father,
    String? mother,
    String? address,
    String? idenDocu,
    String? photo,

  }) async {
    return await repository.memberRegistration(
      givenName: givenName,
    
      phone: phone,

      sureName: sureName,
      email: email,
      niD: niD,
      biCNo: biCNo,
      passportNo: passportNo,
      nationality: nationality,
      gender: gender,
      father: father,
      mother: mother,
      address: address,
      idenDocu: idenDocu,
      photo: photo,
      
    );
  }
}
