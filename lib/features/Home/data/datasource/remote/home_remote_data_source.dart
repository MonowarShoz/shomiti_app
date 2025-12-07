import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/child_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/parent_menu_model.dart';


abstract class HomeRemoteDataSource {
  Future<ApiResult<List<ParentMenuModel>?>> getParentUserMenu(String token, int companyId);
   Future<ApiResult<List<ChildMenuModel>?>> getChildUserMenu(String token, int parentid);
  
}
