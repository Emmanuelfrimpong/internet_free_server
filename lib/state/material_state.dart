import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/models/material_model.dart';

import '../services/database_services.dart';

final materialFutureProvider = FutureProvider<List<MaterialModel>>((ref) async {
  final response = await ServicesApi.getMaterials();
    final List<MaterialModel> materials;
    final List<dynamic> materialsJson = response;
    materials = materialsJson.map((e) => MaterialModel.fromMap(e as Map<String,dynamic>)).toList();
    return materials;

});

final materialDataProvider=StateNotifierProvider<MaterialData,MaterialModel>((ref)=>MaterialData());

class MaterialData extends StateNotifier<MaterialModel> {
  MaterialData() : super(MaterialModel());

  void createNewMaterial(WidgetRef ref) {}
  
}