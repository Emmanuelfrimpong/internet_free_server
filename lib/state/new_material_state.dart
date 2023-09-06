import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/core/components/widgets/smart_dialog.dart';
import 'package:internet_free_server/models/material_model.dart';

import '../services/database_services.dart';
import 'material_state.dart';

final newMaterislProvider=StateNotifierProvider<NewMaterial,MaterialModel>((ref) {
  return NewMaterial();
});

class NewMaterial extends StateNotifier<MaterialModel> {
  NewMaterial() : super(MaterialModel());

  void createNewMaterial(WidgetRef ref) {}

  void setDescription(String s) {
    state = state.copyWith(description: s);
  }

  void setTitle(String s) {
    state = state.copyWith(title: s);
  }

  void setFileType(String s) {
    state = state.copyWith(fileType: s);
  }

  void uploadMaterial(PlatformFile uint8list, WidgetRef ref, GlobalKey<FormState> formKey, TextEditingController controller,)async {
    CustomDialog.showLoading(message: 'Uploading Material...');
    state = state.copyWith(
      path: '',
      postById: 'admin',
      postByName: 'admin',
      course: '',
      department: ''
    );
    final (exception, response) = await ServicesApi.uploadMaterial(state,uint8list);
    if(exception!=null){
      CustomDialog.dismiss() ;
      CustomDialog.showError(message: exception.toString(), title: 'Error');
      return;
    }
    CustomDialog.dismiss();
    CustomDialog.showSuccess(title: 'Success',message: 'Material Uploaded Sucessfully');

    if (exception != null) {
      CustomDialog.dismiss() ;
      CustomDialog.showError(message: exception.toString(), title: 'Error');
      return;
    }
    
    CustomDialog.dismiss() ;
    CustomDialog.showSuccess(message: 'Material Uploaded Successfully', title: 'Success');
    if(formKey.currentState!=null){
      formKey.currentState!.reset();
    }
    if(controller.text.isNotEmpty){
      controller.clear();
    }
    ref.refresh(materialFutureProvider);

  }
  
}