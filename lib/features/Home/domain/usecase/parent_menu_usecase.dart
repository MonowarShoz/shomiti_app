import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/parent_menu_model.dart';
import 'package:imsomitiapp/features/Home/domain/Repository/home_repo.dart';

class ParentMenuUsecase {
  final HomeRepo homeRepo;
  ParentMenuUsecase(this.homeRepo);

  Future<ApiResult<List<ParentMenuModel>?>> call() async {
    return await homeRepo.getParentMenuList();
  }
}
