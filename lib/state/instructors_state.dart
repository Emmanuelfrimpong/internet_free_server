import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/instructor_model.dart';
import '../services/database_services.dart';

final instructorFutureProvider=  FutureProvider<List<InstructorsModel>>((ref)async{
  final response = await ServicesApi.getInstructors();
  final List<InstructorsModel> instructors;
  final List<dynamic> instructorsJson = response;
  instructors = instructorsJson.map((e) => InstructorsModel.fromMap(e as Map<String,dynamic>)).toList();
  return instructors;
});

final instructorDataProvider = StateNotifierProvider<InstructorProvider,InstructorsModel>((ref){
  return InstructorProvider();
});

class InstructorProvider extends StateNotifier<InstructorsModel>{
  InstructorProvider():super(InstructorsModel());
  void setInstructor(InstructorsModel instructor){
    state = instructor;
  }

  void updateStudentStatus(InstructorsModel copyWith, WidgetRef ref) {
    
  }
}

