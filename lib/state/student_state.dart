import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/services/file_services.dart';
import '../core/components/widgets/smart_dialog.dart';
import '../models/students_model.dart';
import '../services/database_services.dart';

final studentsFuture = FutureProvider<List<StudentsModel>>((ref) async {
  final response = await ServicesApi.getStudents();
    final List<StudentsModel> students;
    final List<dynamic> studentsJson = response;
    students = studentsJson.map((e) => StudentsModel.fromMap(e as Map<String,dynamic>)).toList();
    return students;

});



final studentsDataProvider = StateNotifierProvider<StudentsDataProvider, List<StudentsModel>>((ref) {
  return StudentsDataProvider();
});

class StudentsDataProvider extends StateNotifier<List<StudentsModel>> {
  StudentsDataProvider() : super([]);

  void setStudents(List<StudentsModel> students) {
    state = students;
  }

  void uploadStudent()async {
     final (exception, path) = await FileServices.pickExcelFIle();
    if (exception != null) {
      CustomDialog.dismiss() ;
      CustomDialog.showError(message: exception.toString(), title: 'Error');
      return;
    }
    CustomDialog.showLoading(message: 'Uploading Students...');
    if (path == null) return;
    final (exception2, data) = await FileServices.readExcelData(path);
    if (exception2 != null) {
      CustomDialog.dismiss();
      CustomDialog.showError(message: exception2.toString(), title: 'Error');
      return;
    }
    final (exception4, students) =
        await FileServices.getStudentsFromExcel(data);
    if (exception4 != null) {
      CustomDialog.dismiss() ;
      CustomDialog.showError(message: exception4.toString(), title: 'Error');
      return;
    }

    final (exception3, response) = await ServicesApi.uploadStudents(students!);
    if (exception3 != null) {
      CustomDialog.dismiss() ;
      CustomDialog.showError(message: exception3.toString(), title: 'Error');
      return;
    }
    if(response.statusCode != 200){
      CustomDialog.dismiss() ;
      CustomDialog.showError(message: 'Error Uploading Students', title: 'Error');
      return;
    }
    CustomDialog.dismiss();
    CustomDialog.showSuccess(message: 'Students Uploaded Successfully', title: 'Success');
    
  }

  void updateStudentStatus(StudentsModel copyWith, WidgetRef ref)async {
    final (exception, response) = await ServicesApi.updateStudentStatus(copyWith);
    if (exception != null) {
      CustomDialog.showError(message: exception.toString(), title: 'Error');
      return;
    }
    if(response.statusCode != 200){
      CustomDialog.showError(message: 'Error Updating Student', title: 'Error');
      return;
    }
    //refresh students from studentsFuture
    ref.refresh(studentsFuture);
    CustomDialog.showSuccess(message: 'Student Updated Successfully', title: 'Success');
  }
}