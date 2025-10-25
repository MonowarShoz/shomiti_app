import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/domain/Repository/home_repo.dart';

class HomeMenuUsecase {
  final HomeRepo homeRepo;
  HomeMenuUsecase(this.homeRepo);

  Future<ApiResult<List<MenuModel>?>> call() async {
    return await homeRepo.getMenuList();
  }
}
