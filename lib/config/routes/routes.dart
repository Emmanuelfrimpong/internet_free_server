import 'package:auto_route/auto_route.dart';
import '../../pages/admin/admin_home.dart';
import '../../pages/admin/components/classes/classes_screen.dart';
import '../../pages/admin/components/classes/new_class.dart';
import '../../pages/admin/components/dashboard_screen.dart';
import '../../pages/admin/components/instructor/instructors_screen.dart';
import '../../pages/admin/components/instructor/new_instructor.dart';
import '../../pages/admin/components/materials/material_screen.dart';
import '../../pages/admin/components/settings_screen.dart';
import '../../pages/admin/components/students/new_student.dart';
import '../../pages/admin/components/students/students_screen.dart';
import '../../pages/auth/login_page.dart';
import '../../pages/main/components/chat_screen.dart';
import '../../pages/main/components/classes_screen.dart';
import '../../pages/main/components/courses_screen.dart';
import '../../pages/main/components/resources_screen.dart';
import '../../pages/main/main_home_page.dart';
import '../../pages/admin/components/materials/new_material_page.dart';
part 'routes.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: MainHomeRoute.page,
            path: '/',
            initial: true,
            children: [
              AutoRoute(page: LoginRoute.page, path: 'login'),
              AutoRoute(
                  page: ResourcesRoute.page,
                  path: 'resources',
                  initial: true),
              AutoRoute(page: MainCoursesRoute.page, path: 'courses'),
              AutoRoute(page: MainClassesRoute.page, path: 'classrooms'),
              AutoRoute(page: ChatRoute.page, path: 'chat'),
            ]),

        AutoRoute(page: AdminHomeRoute.page, path: '/admin-home', children: [
          RedirectRoute(path: '', redirectTo: 'dashboard'),
          AutoRoute(
              page: DashBoardRoute.page, path: 'dashboard', initial: true),
          AutoRoute(page: StudentsRoute.page, path: 'students'),
          AutoRoute(page: InstructorsRoute.page, path: 'instructors'),
          AutoRoute(page: MaterialsRoute.page, path: 'materials'),
          AutoRoute(page: ClassesRoute.page, path: 'classes'),
          AutoRoute(page: SettingsRoute.page, path: 'settings'),
          AutoRoute(page: NewMaterialRoute.page, path: 'new-material'),
          AutoRoute(page: NewClassRoute.page, path: 'new-class'),
          AutoRoute(page: NewInstructorRoute.page, path: 'new-instructor'),
          AutoRoute(page: NewStudentRoute.page, path: 'new-student'),
          
        ]),
        // redirect / to /login

        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}
