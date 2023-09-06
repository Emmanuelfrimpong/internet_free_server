import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/models/classes_model.dart';

import '../services/database_services.dart';

final classDataFutureProvider=FutureProvider<List<ClassModel>>((ref)async{
  final response = await ServicesApi.getClasses();
  final List<ClassModel> classes;
  final List<dynamic> classesJson = response;
  classes = classesJson.map((e) => ClassModel.fromMap(e as Map<String,dynamic>)).toList();
  return classes;
});