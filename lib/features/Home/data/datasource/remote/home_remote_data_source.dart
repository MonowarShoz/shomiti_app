import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';


abstract class HomeRemoteDataSource {
  Future<ApiResult<List<MenuModel>?>> getUserMenu(String token, String roleName);
  
}
