import 'package:dio/dio.dart';
import 'package:imsomitiapp/features/Home/data/datasource/remote/model/home_menu_model.dart';
import 'package:imsomitiapp/features/Member_info/data/data_source/remote/model/member_info_save_model.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_request_model.dart';
import 'package:imsomitiapp/features/auth/data/data_source/remote/model/login_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:imsomitiapp/core/networking/api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequestBody);

  // @POST(ApiConstants.registrationRoute)
  // Future<String> schoolRegistration(@Body() SchRegModel schoolRegBody);

  // @POST(ApiConstants.teacherRegistration)
  // Future<String> teacherRegistration(
  //   @Header("Authorization") String token,
  //   @Body() TeacherRegistrationModel teacherRegBody,
  // );
  // @POST(ApiConstants.studentRegistration)
  // Future<String> studentRegistration(
  //   @Header("Authorization") String token,
  //   @Body() StudentRegistration studentRegBody,
  // );
  // @POST(ApiConstants.saveClassRoute)
  // Future<String> saveClass(
  //   @Header("Authorization") String token,
  //   @Body() SaveClassModel classRegBody,
  // );

  // @POST(ApiConstants.saveShiftRoute)
  // Future<String> saveShift(
  //   @Header("Authorization") String token,
  //   @Body() SaveShiftModel shiftRegBody,
  // );
  // @POST(ApiConstants.saveSectionRoute)
  // Future<String> saveSection(
  //   @Header("Authorization") String token,
  //   @Body() SaveSectionModel sectionRegBody,
  // );
  // @POST(ApiConstants.saveSubjectRoute)
  // Future<String> saveSubject(
  //   @Header("Authorization") String token,
  //   @Body() SaveSubjectModel subjectBody,
  // );
  // @POST(ApiConstants.saveNotice)
  // Future<String> saveNotice(
  //   @Header("Authorization") String token,
  //   @Body() NoticeSaveModel noticeBody,
  // );

  // @POST(ApiConstants.saveHomeWork)
  // Future<String> saveHomeWork(
  //   @Header("Authorization") String token,
  //   @Body() SaveHomeWorkBody saveHomeWorkBody,
  // );
  //  @POST(ApiConstants.homeworkMap)
  // Future<String> saveHomeWorkMap(
  //   @Header("Authorization") String token,
  //   @Body() HomeworkMapModel saveHomeWorkBody,
  // );


  @GET(ApiConstants.menuRoute)
  Future<List<MenuModel>> getUserMenu(
    @Header("Authorization") String token,
    @Query("roleName") String roleName,
  );
  @POST(ApiConstants.memberRegistration)
  Future<String>memberRegistration(
    @Header("Authorization") String token,
    @Body() MemberInfoSaveBody memberInfoSaveBody
  );

  // @GET(ApiConstants.schoolLogoRoute)
  // Future<SchoolLogoModel> getSchoolLogo(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  // );

  // @GET(ApiConstants.getTeacherRoute)
  // Future<GetTeacherModel> getTeacherList(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  // );
  // @GET(ApiConstants.getStudentRoute)
  // Future<StudentListModel> getStudentList(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  // );
  // @GET(ApiConstants.getClassRoute)
  // Future<GetClassModel> getClassList(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  // );
  // @GET(ApiConstants.getSectionRoute)
  // Future<GetSectionModel> getSectionList(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  // );
  // @GET(ApiConstants.getShiftRoute)
  // Future<GetShiftModel> getShiftList(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  // );

  // @POST(ApiConstants.teacherMappingRoute)
  // Future<String> setTeacherMapping(
  //   @Header("Authorization") String token,
  //   @Body() TeacherMappingModel teacherMapBody,
  // );

  // @GET(ApiConstants.getSubject)
  // Future<GetSubjectModel> getSubject(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  // );
  // @GET(ApiConstants.getSubjectByClass)
  // Future<GetSubjectModel> getSubjectByClass(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  //   @Query("classid") int classid,
  // );

  // @GET(ApiConstants.getClassMap)
  // Future<GetClassModel> getClassMap(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  //   @Query("phone") String phone,
  // );

  // @GET(ApiConstants.getSectionMap)
  // Future<GetSectionModel> getSectionMap(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  //   @Query("classid") int classid,
  //   @Query("phone") String phone,
  // );
  // @GET(ApiConstants.getShiftMap)
  // Future<GetShiftModel> getShiftMap(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  //   @Query("classid") int classid,
  //   @Query("sectionid") int sectionid,
  //   @Query("phone") String phone,
  // );
  // @GET(ApiConstants.getSubjectMap)
  // Future<GetSubjectModel> getSubjectMap(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  //   @Query("classid") int classid,
  //   @Query("sectionid") int sectionid,
  //   @Query("shift") int shift,
  //   @Query("phone") String phone,
  // );
  // @GET(ApiConstants.getHomeWork)
  // Future<GetHomeworkModel> getHomework(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  //   @Query("classid") int classid,
  //   @Query("sectionid") int sectionid,
  //   @Query("shiftid") int shift,
  //   @Query("subjectid") int subjectid,
  //   @Query("dates") String date,
  // );
  //   @GET(ApiConstants.getHomeWork)
  // Future<GetHomeworkModel> getAllHomework(
  //   @Header("Authorization") String token,
  //   @Query("scid") int scid,
  //   @Query("classid") int classid,
  //   @Query("sectionid") int? sectionid,
  //   @Query("shiftid") int? shift,
  //   @Query("subjectid") int? subjectid,
  //   @Query("dates") String? date,
  // );

  // @GET(ApiConstants.suggestclass)
  // Future<GetSuggestedMenu> getSuggestClass(
  //   @Header("Authorization") String token,
  // );
  // @GET(ApiConstants.suggestSection)
  // Future<GetSuggestedMenu> getSuggestSection(
  //   @Header("Authorization") String token,
  // );
  //  @GET(ApiConstants.suggestShift)
  // Future<GetSuggestedMenu> getSuggestShift(
  //   @Header("Authorization") String token,
  // );
  //  @GET(ApiConstants.suggestSubject)
  // Future<GetSuggestedMenu> getSuggestSubject(
  //   @Header("Authorization") String token,
  // );
}
