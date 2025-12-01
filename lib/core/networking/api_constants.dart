import 'package:imsomitiapp/core/utils/app_strings.dart';

class ApiConstants {
  static const String baseUrl = "http://192.168.20.56:807/";
  //static const String baseUrl = "http://rubims.lged.gov.bd";
  //static const String baseUrl = "http://test.ourhomework.xyz/NotePublish";
  //static const String baseUrl = "http://192.168.66.45/NotePublish";
  //static const String imgUrl = "http://test.ourhomework.xyz";

  //static const String ssoUrl = "http://sso.lged.gov.bd";
  //  static const String ssoUrl = "http://103.119.101.170:3002/";

  static const String login = "/api/Log/login";
  static const String registrationRoute = "/api/RegiCtrl/sch-registration";
  static const String menuRoute = "/api/Menu/childmenu";
  static const String schoolLogoRoute = "/api/RegiCtrl/get-school-logo";

  static const String saveClassRoute = "/api/EntityCtrl/save-class";
  static const String saveShiftRoute = "/api/EntityCtrl/save-shift";
  static const String saveSectionRoute = "/api/EntityCtrl/save-section";
  static const String saveSubjectRoute = "/api/EntityCtrl/save-subject";

  static const String teacherRegistration =
      "/api/RegiCtrl/teacher-registration";
  static const String studentRegistration =
      "/api/RegiCtrl/student-registration";
  static const String getTeacherRoute = "/api/SelectedCtrl/get-teacher";
  static const String getStudentRoute = "/api/SelectedCtrl/get-student";
  static const String getSubject = "/api/EntityCtrl/get-subject";
  static const String getSectionRoute = "/api/EntityCtrl/get-section";
  static const String getShiftRoute = "/api/EntityCtrl/get-shift";
  static const String getClassRoute = "/api/EntityCtrl/get-class";
  static const String teacherMappingRoute = "/api/MapperCtrl/teacher-map";
  static const String getSubjectByClass = "/api/EntityCtrl/get-subjectbyclass";
  static const String getClassMap = "/api/MapperCtrl/get-class-map";
  static const String getShiftMap = "/api/MapperCtrl/get-shift-map";
  static const String getSectionMap = "/api/MapperCtrl/get-section-map";
  static const String getSubjectMap = "/api/MapperCtrl/get-subject-map";
  static const String getMap = "/api/MapperCtrl/get-map";
  static const String saveHomeWork = "/api/HwCtrl/save-homework";
  static const String homeworkMap = "/api/MapperCtrl/homework-map";
  static const String getHomeworkMap = "/api/MapperCtrl/get-homeworkmap";
  static const String getHomeWork = "/api/HwCtrl/get-homework";
  static const String getAllHomeWork = "/api/HwCtrl/get-all-homework";
  static const String editLogo = "/api/RegiCtrl/edit-logo";

  static const String suggestclass = "/api/SuggestCtrl/get-sug-class";
  static const String suggestSection = "/api/SuggestCtrl/get-sug-section";
  static const String suggestShift = "/api/SuggestCtrl/get-sug-shift";
  static const String suggestSubject = "/api/SuggestCtrl/get-sug-subject";

  static const String saveNotice = "/api/NoticeCtrl/save-notice";
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
