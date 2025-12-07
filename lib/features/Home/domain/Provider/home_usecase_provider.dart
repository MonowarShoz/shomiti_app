import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/features/Home/data/provider/home_data_provider.dart';
import 'package:imsomitiapp/features/Home/domain/usecase/child_menu_usecase.dart';
import 'package:imsomitiapp/features/Home/domain/usecase/parent_menu_usecase.dart';

final parentMenuUsecaseProvider = FutureProvider<ParentMenuUsecase>((ref) async {
  final homeRepo = await ref.read(homeDataRepositoryProvider.future);
  return ParentMenuUsecase(homeRepo);
});
final childMenuUsecaseProvider = FutureProvider<ChildMenuUsecase>((ref) async{
  final homeRepo = await ref.read(homeDataRepositoryProvider.future);
  return ChildMenuUsecase(homeRepo);
},);