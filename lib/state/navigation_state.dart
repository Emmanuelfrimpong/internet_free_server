import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/routes/routes.dart';
import '../core/components/constants/enums.dart';

final sideBarWithProvider= StateProvider<double>((ref) => 60);

final adminNavigationProvider=StateNotifierProvider<AdminNavigation,AdminHomePages>((ref){
  return AdminNavigation();
});

class AdminNavigation extends StateNotifier<AdminHomePages> {
  AdminNavigation() : super(AdminHomePages.dashboard);


  void changeNavigation(AdminHomePages page) {
    state = page;
  }
  
  void getInitialPage(BuildContext context) {
  var currentRoute = AutoRouter.of(context).current.name;
  if(DashBoardRoute.name.toLowerCase().contains(currentRoute.toLowerCase())){
    state=AdminHomePages.dashboard;
  }else if(StudentsRoute.name.toLowerCase().contains(currentRoute.toLowerCase())){
    state=AdminHomePages.students;
  }else if(InstructorsRoute.name.toLowerCase().contains(currentRoute.toLowerCase())){
    state=AdminHomePages.instructors;
  }else if(MaterialsRoute.name.toLowerCase().contains(currentRoute.toLowerCase())){
    state=AdminHomePages.materials;
  }else if(SettingsRoute.name.toLowerCase().contains(currentRoute.toLowerCase())){
    state=AdminHomePages.settings;
  }
  }

}

final isWebProvider=StateProvider<bool>((ref)=>kIsWeb);

final mainHomePageProvider=StateProvider<int>((ref)=>0);
final bottomNavProvider=StateProvider<int>((ref)=>0);