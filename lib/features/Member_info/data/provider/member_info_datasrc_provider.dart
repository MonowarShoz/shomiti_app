
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/base_provider.dart';
import 'package:imsomitiapp/features/Home/data/provider/home_data_provider.dart';

import 'package:imsomitiapp/features/Member_info/data/data_source/remote/member_info_remote_source.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/member_info_remote_src_impl.dart';
import 'package:imsomitiapp/features/Member_info/data/repository/member_info_repository_impl.dart';
import 'package:imsomitiapp/features/Member_info/domain/repository/member_info_repository.dart';


final memberInfoRemoteDataSrcProvider = FutureProvider<MemberInfoRemoteSource>((ref) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return MemberInfoRemoteSrcImpl(apiService: apiService, ref: ref);
});

final memberInfoRepositoryInfoProvider = FutureProvider<MemberInfoRepository>((ref) async{
  final localDataSrc = await ref.read(homelocalDataSourceProvider.future);
  final remoteDataSrc = await ref.read(memberInfoRemoteDataSrcProvider.future);
  return MemberInfoRepositoryImpl(localDataSource:localDataSrc ,memberInfoRemoteSource: remoteDataSrc);
   
  
},);