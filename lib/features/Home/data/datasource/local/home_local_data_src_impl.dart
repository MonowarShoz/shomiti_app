import 'package:imsomitiapp/core/base/base_local_data_source.dart';
import 'package:imsomitiapp/features/home/data/datasource/local/home_local_data_source.dart';

class HomeLocalDataSrcImpl extends BaseLocalDataSource implements HomeLocalDataSource{
  HomeLocalDataSrcImpl({super.prefs});
  
  @override
  Future<String?> getUserInformation() async{
    return await getuserInfo();
  }
  
  @override
  Future<String?> getToken() async{
    
    return await getAuthToken();
  }
}