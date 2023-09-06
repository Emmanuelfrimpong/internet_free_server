import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart'as http;
import 'package:internet_free_server/core/components/widgets/smart_dialog.dart';
import 'package:internet_free_server/models/instructor_model.dart';
import 'package:internet_free_server/models/material_model.dart';
import 'package:internet_free_server/models/students_model.dart';
import 'package:dio/dio.dart';
import 'package:internet_free_server/state/auth_state.dart';

class ServicesApi {
   static final dio = Dio();
  static const String BASE_URL = 'http://192.168.1.2:3000/';
  static const String LOGIN = '${BASE_URL}login';
  static const String CREATE_ADMIN = '${BASE_URL}add-admin';
  static const String ADMIN_LOGIN = '${BASE_URL}admin-login';
  static const String GET_STUDENTS = '${BASE_URL}students';
  static const String UPLOAD_STUDENTS = '${BASE_URL}upload-students';
  static const String UPDATE_STUDENT = '${BASE_URL}update-student';
  static const String UPLOAD_MATERIAL = '${BASE_URL}upload-material';
  static const String GET_MATERIALS = '${BASE_URL}materials';
  static const String GET_INSTRUCTORS = '${BASE_URL}instructors';
  static const String GET_CLASSES = '${BASE_URL}classes';
  static const String ADD_INSTRUCTOR = '${BASE_URL}add-instructor';



  static Future<dynamic> createAdmin() async {
    try {
      // use dio to make request
      final response = await dio.get(CREATE_ADMIN);
      return response.data['statusCode'];
    } catch (e) {
      CustomDialog.showError(title: 'Server Error', message: 'Server is not responding');
      return 500;
    }
  }

  static Future logAdminIn(AuthData state) async {
    try {
      Uri uri = Uri.parse(ADMIN_LOGIN);
      var body = jsonEncode({
        'email': state.email,
        'password': state.password,
      });
      final response = await dio.postUri(uri, data: body);
      return response;
    } catch (e) {
      
      return e;
    }
  }
  //get students

  static Future<List<dynamic>> getStudents() async {
    try {
      final response = await dio.get(GET_STUDENTS);
      if(response.statusCode==200){
        List<dynamic> data= response.data['students'].map((e)=>Map<String,dynamic>.from(e)).toList();
        return data;  
      }else{
        return <dynamic>[];
      }
    } catch (e) {
      return <dynamic>[];
    }
  }

  static Future<(Exception?, Response)> uploadStudents(List<StudentsModel> list)async {
    try {
      Uri uri = Uri.parse(UPLOAD_STUDENTS);
      var body = jsonEncode(list.map((e) => e.toMap()).toList());
      final response = await dio.postUri(uri, data: body);
      return Future.value((null, response));
    } catch (e) {
      return Future.value((Exception(e.toString()), Response(requestOptions: RequestOptions(path: ''))));
    }
  }

  static Future<(Exception?, Response)> updateStudentStatus(StudentsModel copyWith) async{
    try {
      Uri uri = Uri.parse(UPDATE_STUDENT);
      var body = jsonEncode(copyWith.toMap());
      final response = await dio.putUri(uri, data: body);
      return Future.value((null, response));
    } catch (e) {
      return Future.value((Exception(e.toString()), Response(requestOptions: RequestOptions(path: ''))));
    }
  }

  static Future<(Exception?,String?)> uploadMaterial(MaterialModel state, PlatformFile file) async{
    try {
final request = http.MultipartRequest(
      "POST",
      Uri.parse(UPLOAD_MATERIAL),
    );
    //-----add other fields if needed
    request.fields["title"] = state.title!;
    request.fields["description"] = state.description!;
    request.fields["course"] = state.course!;
    request.fields["department"] = state.department!;
    request.fields["fileType"] = state.fileType!;
    request.fields["postById"] = state.postById!;
    request.fields["postByName"] = state.postByName!;
    request.fields["path"] = state.path!;
   
    //-----add selected file with request
    request.files.add( http.MultipartFile(
        "file", file.readStream!, file.size,
        filename: file.name));

    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();
    return Future.value((null,result));

    } catch (e) {
      return Future.value((Exception(e.toString()), null));
    }
  }

  static Future<List<dynamic>>getMaterials() async{
    try {
      final response = await dio.get(GET_MATERIALS);
      if(response.statusCode==200){
        List<dynamic> data= response.data['materials'].map((e)=>Map<String,dynamic>.from(e)).toList();
        return data;  
      }else{
        return <dynamic>[];
      }
    } catch (e) {
      return <dynamic>[];
    }
  }

  static Future<List<dynamic>>getInstructors()async {
    try {
      final response = await dio.get(GET_INSTRUCTORS);
      if(response.statusCode==200){
        List<dynamic> data= response.data['instructors'].map((e)=>Map<String,dynamic>.from(e)).toList();
        return data;  
      }else{
        return <dynamic>[];
      }
    } catch (e) {
      return <dynamic>[];
    }
  }

  static  Future<List<dynamic>> getClasses()async {
    try {
      final response = await dio.get(GET_CLASSES);
      if(response.statusCode==200){
        List<dynamic> data= response.data['classes'].map((e)=>Map<String,dynamic>.from(e)).toList();
        return data;  
      }else{
        return <dynamic>[];
      }
    } catch (e) {
      return <dynamic>[];
    }
  }

  static Future<(Exception? ,Response?)>addInstructor(InstructorsModel state)async {
    try {
      Uri uri = Uri.parse(ADD_INSTRUCTOR);
      var body = jsonEncode(state.toMap());
      final response = await dio.postUri(uri, data: body);
      return Future.value((null, response));
    } catch (e) {
      return Future.value((Exception(e.toString()), Response(requestOptions: RequestOptions(path: ''))));
    }
  }

 

}
