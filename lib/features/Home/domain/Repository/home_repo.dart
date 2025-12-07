import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/child_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/parent_menu_model.dart';

abstract class HomeRepo {
   Future<ApiResult<List<ParentMenuModel>?>> getParentMenuList();
   Future<ApiResult<List<ChildMenuModel>?>> getChildMenuList({required int parentID});
}