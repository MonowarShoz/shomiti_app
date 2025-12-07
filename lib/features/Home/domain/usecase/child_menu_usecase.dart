import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/child_menu_model.dart';
import 'package:imsomitiapp/features/Home/domain/Repository/home_repo.dart';

class ChildMenuUsecase {
  final HomeRepo homeRepo;
  ChildMenuUsecase(this.homeRepo);

  Future<ApiResult<List<ChildMenuModel>?>>call({required int parentID})async{
    return await homeRepo.getChildMenuList(parentID: parentID);
  }
}