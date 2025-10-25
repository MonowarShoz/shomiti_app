import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/Home/data/provider/home_data_provider.dart';
import 'package:imsomitiapp/features/Home/domain/usecase/menu_usecase.dart';

final homeMenuUsecaseProvider = FutureProvider<HomeMenuUsecase>((ref) async {
  final homeRepo = await ref.read(homeDataRepositoryProvider.future);
  return HomeMenuUsecase(homeRepo);
});