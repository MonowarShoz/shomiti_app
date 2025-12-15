import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/Member_info/data/provider/member_info_datasrc_provider.dart';
import 'package:imsomitiapp/features/Member_info/domain/usecase/member_info_usecase.dart';
import 'package:imsomitiapp/features/Member_info/domain/usecase/member_registration_usecase.dart';

final memberRegUsecaseProvider = FutureProvider<MemberRegistrationUsecase>((ref) async {
  final repository = await ref.read(memberInfoRepositoryInfoProvider.future);
  return MemberRegistrationUsecase(repository: repository);
  
});

final memberInfoDataProvider = FutureProvider<MemberInfoDataUsecase>((ref) async{
  final repository = await ref.read(memberInfoRepositoryInfoProvider.future);
  return MemberInfoDataUsecase(repository: repository);
},);