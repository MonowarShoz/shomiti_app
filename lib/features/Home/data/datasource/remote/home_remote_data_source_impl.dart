import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imsomitiapp/core/base/remote_data_source.dart';
import 'package:imsomitiapp/core/networking/api_result.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/home_remote_data_source.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/child_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/parent_menu_model.dart';


class HomeRemoteDataSourceImpl extends BaseRemoteDataSource
    implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required super.apiService, required super.ref});

  @override
  Future<ApiResult<List<ChildMenuModel>?>> getChildUserMenu(String token, int parentid) {
    return safeApiCall(() async{
      return await apiService.getChilUserMenu(token, parentid);
    }, );
  }

  @override
  Future<ApiResult<List<ParentMenuModel>?>> getParentUserMenu(String token, int companyId) {
     return safeApiCall(() async{
      return await apiService.getParentUserMenu(token, companyId);
    }, );
  }

 

  
}
