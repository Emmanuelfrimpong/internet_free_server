import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/core/components/widgets/smart_dialog.dart';
import 'package:internet_free_server/state/student_state.dart';
import '../models/students_model.dart';
import '../services/database_services.dart';
final autoGenerateProvider = FutureProvider<String>((ref) async {
  //get all students from db
  var data = await ServicesApi.getStudents();
  final List<StudentsModel> students;
  final List<dynamic> studentsJson = data;
  students = studentsJson
      .map((e) => StudentsModel.fromMap(e as Map<String, dynamic>))
      .toList();
  //generate 10 random code and make sure they are not in the db
  String newId;
  bool isUniqueId = false;

  do {
    final random = Random();
    final uniqueId = StringBuffer();
    for (int i = 0; i < 10; i++) {
      uniqueId.write(random.nextInt(10));
    }
    newId = uniqueId.toString();
    var existingIds =
        students.where((element) => element.indexNumber == newId).toList();
    if (existingIds.isEmpty) {
      isUniqueId = true;
    }
  } while (!isUniqueId);
  return newId;
});

final newStudentProvider =
    StateNotifierProvider<NewStudentProvider, StudentsModel>((ref) {
  return NewStudentProvider();
});

class NewStudentProvider extends StateNotifier<StudentsModel>{
   NewStudentProvider() : super(StudentsModel());

  void setIndexNumber(String s) {
    state = state.copyWith(indexNumber: s);
  }

  void setFullName(String s) {
    state = state.copyWith(name: s);
  }

  void setGender(String gender) {
    state =state.copyWith(gender: gender);

  }
 void setEmail(String s) {
    state = state.copyWith(email: s);
  }
  void setPhoneNumber(String s) {
    state = state.copyWith(phoneNumber: s);
  }

  void setDepartment(String department) {
    state = state.copyWith(department: department);
  }

  void saveStudent(WidgetRef ref, GlobalKey<FormState> formKey, TextEditingController indexNumberController)async {
    CustomDialog.showLoading(message: 'Saving Student...');
    state = state.copyWith(status: 'active',
    about: '',
    isOnline: false,
    profileUrl: '',
    password: state.indexNumber,
    );
    final (exception, response) = await ServicesApi.uploadStudents([state]);
    if (exception != null) {
      CustomDialog.dismiss();
      CustomDialog.showError(message: exception.toString(), title: 'Error');
      return;
    }
    if(response.statusCode != 200){
      CustomDialog.dismiss();
      CustomDialog.showError(message: 'Error Saving Student', title: 'Error');
      return;
    }
    ref.refresh(studentsFuture);
    if(formKey.currentState!=null) {
      formKey.currentState!.reset();
      indexNumberController.clear();
    }
    CustomDialog.dismiss();
    CustomDialog.showSuccess(message: 'Student Saved Successfully', title: 'Success');
    
  }

 

}