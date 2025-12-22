import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/usecase/kisty_save_usecase.dart';
import 'package:imsomitiapp/features/kistiAndSubscription/domain/usecase/kisty_type_info_usecase.dart';

import '../../data/provider/kisty_remote_src_provider.dart';
import '../usecase/crtype_usecase.dart';

final crtypeUsecaseProvider = FutureProvider<CrTypeUsecase>((ref) async {
  final kistirepo = await ref.read(kistyRepoProvider.future);
  return CrTypeUsecase(kistyRepository: kistirepo);
});

final kistiInfoUsecaseProvider = FutureProvider<KistyTypeInfoUsecase>((ref) async {
  final kistirepo = await ref.read(kistyRepoProvider.future);
  return KistyTypeInfoUsecase(kistyRepository: kistirepo);
});

final kistiSaveusecaseProvider = FutureProvider<KistySaveUsecase>((ref) async{
  final kistirepo = await ref.read(kistyRepoProvider.future);
  return KistySaveUsecase(kistyRepository: kistirepo);

},);
