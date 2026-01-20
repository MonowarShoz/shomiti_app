import 'package:imsomitiapp/core/utils/app_strings.dart';

class ApiConstants {
  static const String baseUrl = "http://192.168.20.194:807";
  //static const String baseUrl = "http://rubims.lged.gov.bd";
  //static const String baseUrl = "http://test.ourhomework.xyz/NotePublish";
  //static const String baseUrl = "http://192.168.66.45/NotePublish";
  //static const String imgUrl = "http://test.ourhomework.xyz";

  //static const String ssoUrl = "http://sso.lged.gov.bd";
  //  static const String ssoUrl = "http://103.119.101.170:3002/";

  static const String login = "/api/Log/login";
  
  static const String parentmenuRoute = "/api/Menu/parentmenu";
  static const String childmenuRoute = "/api/Menu/childmenu";

  // Member Info
  static const String memberRegistration = "/api/Memb/savemember";
  static const String memberInfoEdit = "/api/Memb/editmember";
  static const String memberInfoAll = "/api/Memb/memberinfoall";


  // Staff Info
  static const String staffsave = "/api/StaffCtrl/save-staff";
  static const String staffInfo = "/api/StaffCtrl/getstaffinfo";
  static const String saveStaffDesignation = "/api/StaffCtrl/save-staff-designation";

  //kisti
  static const String crType = "/api/KistiCtrl/crtype";
  static const String kistiType = "/api/KistiCtrl/kistytype";
  static const String kistiTypeById = "/api/KistiCtrl/kistytypebyid";
  static const String kistireceivehistory = "/api/KistiCtrl/kistireceivehistory";
  static const String kistiTypeByProject = "/api/KistiCtrl/kistytypebyproject";
  static const String savekistiType = "/api/KistiCtrl/savekistitype";
  //subscription type
  static const String subscriptionTypeEntry = "/api/SubscriptionCtrl/savesubscriptiontype";
  static const String getsubscriptiontypes = "/api/SubscriptionCtrl/subscriptiontypes";


  //project
  static const String projectInfo = "/api/ProjectCtrl/getproject";
  static const String saveproject = "/api/ProjectCtrl/save-project";
  static const String saveassignproject = "/api/ProjectCtrl/save-assign-project";
  static const String getassign = "/api/ProjectCtrl/getassign";


  //Accounts
  static const String getBalanceWithdraw = "/api/AccountCtrl/get-Balance-withdraw";
  static const String saveBalanceWithdraw = "/api/AccountCtrl/save-withdraw";
  static const String saveBalanceSegment = "/api/AccountCtrl/savebalancesegment";
  static const String getvendor = "/api/AccountCtrl/vendor";
  static const String accountBalance = "/api/AccountCtrl/accountbalance";


 

  
}

class ApiErrors {
  static const String badRequestError = AppStrings.badRequestError;
  static const String noContent = AppStrings.noContentError;
  static const String forbiddenError = AppStrings.forbiddenError;
  static const String unauthorizedError = AppStrings.unauthorizedError;
  static const String notFoundError = AppStrings.notFoundError;
  static const String conflictError = AppStrings.conflictError;
  static const String internalServerError = AppStrings.internalServerError;
  static const String unknownError = AppStrings.unexpectedError;
  static const String timeoutError = AppStrings.timeoutError;
  static const String defaultError = AppStrings.defaultError;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetError = AppStrings.noInternetError;
  static const String loadingMessage = AppStrings.loadingMessage;
  static const String retryAgainMessage = AppStrings.retryAgainMessage;
}
