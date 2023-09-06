import 'dart:math';

import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/core/components/widgets/smart_dialog.dart';
import '../models/instructor_model.dart';
import '../services/database_services.dart';


final autoGenerateInstructorIdProvider = FutureProvider<String>((ref) async {
  //get all students from db
  var data = await ServicesApi.getInstructors();
  final List<InstructorsModel> students;
  final List<dynamic> instructorJson = data;
  students = instructorJson
      .map((e) => InstructorsModel.fromMap(e as Map<String, dynamic>))
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
        students.where((element) => element.id == newId).toList();
    if (existingIds.isEmpty) {
      isUniqueId = true;
    }
  } while (!isUniqueId);
  return newId;
});

final newInstructorProvider =
    StateNotifierProvider<NewInstructorProvider, InstructorsModel>((ref) {
  return NewInstructorProvider();
});

class NewInstructorProvider extends StateNotifier<InstructorsModel>{
  NewInstructorProvider():super(InstructorsModel());

  void setId(String s) {
    state = state.copyWith(id: s);
  }

  void setFullName(String s) {
    state = state.copyWith(name: s);
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
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

  void saveInstructor(WidgetRef ref, GlobalKey<FormState> formKey, TextEditingController indexNumberController)async {
    CustomDialog.showLoading(message: 'Saving Instructor...');
    state = state.copyWith(status: 'active',
    about: '',
    isOnline: false,
    profileUrl: '',
    password: state.id,
    );
    final (exception, response) = await ServicesApi.addInstructor(state);
    if (exception != null) {
      CustomDialog.dismiss();
      CustomDialog.showError(message: exception.toString(), title: 'Error');
      return;
    }
    if(response!.statusCode != 200){
      CustomDialog.dismiss();
      CustomDialog.showError(message: 'Error Saving Instructor', title: 'Error');
      return;
    }
    if(formKey.currentState!.validate()){
      indexNumberController.clear();
      formKey.currentState!.reset();
    }
    CustomDialog.dismiss();
    CustomDialog.showSuccess(message: 'Instructor Saved Successfully', title: 'Success');
  }
}

