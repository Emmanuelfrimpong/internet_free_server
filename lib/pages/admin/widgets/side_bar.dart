import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/routes/routes.dart';
import '../../../core/components/constants/enums.dart';
import '../../../state/navigation_state.dart';
import '../../../styles/colors.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = ref.watch(sideBarWithProvider);
    var size = MediaQuery.of(context).size;
    return Container(
      width: width,
      color: primaryColor,
      height: size.height,
      child: Column(
          crossAxisAlignment:
              width < 100 ? CrossAxisAlignment.center : CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 20,
            ),
            IconButton(
                onPressed: () {
                  if (ref.watch(sideBarWithProvider) == 60) {
                    ref.read(sideBarWithProvider.notifier).state = 200;
                  } else {
                    ref.read(sideBarWithProvider.notifier).state = 60;
                  }
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 40,
            ),
             const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ 
                  SideBarItem(
                    destination: DashBoardRoute(),
                    title: 'Dashboard',
                    icon: Icons.apps,
                    page: AdminHomePages.dashboard,
                  ),
                  SideBarItem(
                    destination: StudentsRoute(),
                    title: 'Students',
                    icon: Icons.person,
                    page: AdminHomePages.students,
                  ),
                  SideBarItem(
                    destination: InstructorsRoute(),
                    title: 'Instructors',
                    icon: Icons.person,
                    page: AdminHomePages.instructors,
                  ),
                  SideBarItem(
                    destination: MaterialsRoute(),
                    title: 'Learning Materials',
                    icon: Icons.library_books,
                    page: AdminHomePages.materials,
                  ),
                  
                   SideBarItem(
                    destination: ClassesRoute(),
                    title: 'Classes',
                    icon: Icons.room,
                    page: AdminHomePages.classes,
                  ),
                  
                ],
              ),
            ),
          ]),
    );
  }
}

class SideBarItem extends ConsumerStatefulWidget {
  const SideBarItem( {super.key, this.title, this.icon, this.destination,this.page});
  final String? title;
  final IconData? icon;
  final PageRouteInfo<dynamic>? destination;
  final AdminHomePages? page;

  @override
  ConsumerState<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends ConsumerState<SideBarItem> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    var size = ref.watch(sideBarWithProvider);
    return InkWell(
        onHover: (value) {
          setState(() {
            isHovered = value;
          });
        },
        onTap: () {
          ref.read(adminNavigationProvider.notifier).changeNavigation( widget.page!);
          AutoRouter.of(context).push(widget.destination!);
        },
        child: Container(
          width: size,
          height: 50,
          color: isHovered
              ? Colors.white.withOpacity(0.5)
              :ref.watch(adminNavigationProvider) ==
                      widget.page
                  ? Colors.white
                  : Colors.transparent,
          child: size < 100
              ? Center(
                  child: Icon(
                    widget.icon,
                    color:ref.watch(adminNavigationProvider) ==
                      widget.page?primaryColor: Colors.white,
                  ),
                )
              : Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    widget.icon,
                   color:ref.watch(adminNavigationProvider) ==
                      widget.page?primaryColor: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.title!,
                    style:  TextStyle( color:ref.watch(adminNavigationProvider) ==
                      widget.page?primaryColor: Colors.white,),
                  )
                ]),
        ));
  }
}
