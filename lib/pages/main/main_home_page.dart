import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/config/routes/routes.dart';
import 'package:internet_free_server/generated/assets.dart';
import 'package:internet_free_server/pages/main/widgets/topbar_item.dart';
import 'package:internet_free_server/styles/colors.dart';
import '../../state/navigation_state.dart';
import '../../state/user_state.dart';

@RoutePage()
class MainHomePage extends ConsumerStatefulWidget {
  const MainHomePage({super.key});

  @override
  ConsumerState<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends ConsumerState<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    var isWeb = ref.watch(isWebProvider);
    return LayoutBuilder(builder: (context, size) {
      return Scaffold(
        body: const AutoRouter(),
        appBar:  AppBar(
                backgroundColor: primaryColor,
                title: Row(
                  children: [
                    // logo
                    const SizedBox(width: 10),
                    Image.asset(
                      Assets.logos2,
                      height: 40,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Internet Free Server',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                actions:isWeb&&size.maxWidth>800?  [

                  const TopBarItem(
                    'Material',
                    0,
                    ResourcesRoute()
                  ),
                  const TopBarItem(
                    'Courses',
                    1,
                    MainCoursesRoute()
                  ),
                  const TopBarItem(
                    'Classroom',
                    2,
                    MainClassesRoute()
                  ),
                  const TopBarItem(
                    'Chat',
                    3,
                    ChatRoute()
                  ),
                  if(ref.watch(userProvider)!=null)
                  PopupMenuButton(
                    child: CircleAvatar(
                      backgroundImage:ref.watch(userProvider)!.image!=null? NetworkImage(ref.watch(userProvider)!.image!):null,
                      radius: 25,
                    ),
                    itemBuilder:(context) {
                      return [
                        const PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 10,),
                              Text('Profile'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(Icons.logout),
                              SizedBox(width: 10,),
                              Text('Logout'),
                            ],
                          ),
                        ),
                      ];
                    
                    }),
                     if(ref.watch(userProvider)==null)
                     const TopBarItem('Login', 4, LoginRoute()),
                  const SizedBox(width: 20,)
                ]:[
                   if(ref.watch(userProvider)!=null)
                  PopupMenuButton(
                    child: CircleAvatar(
                      backgroundImage:ref.watch(userProvider)!.image!=null? NetworkImage(ref.watch(userProvider)!.image!):null,
                      radius: 25,
                    ),
                    itemBuilder:(context) {
                      return [
                        const PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 10,),
                              Text('Profile'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(Icons.logout),
                              SizedBox(width: 10,),
                              Text('Logout'),
                            ],
                          ),
                        ),
                      ];
                    
                    }),
                     if(ref.watch(userProvider)==null)
                     PopupMenuButton(
                      onSelected: (value) {
                        if(value==0) {   
                          ref.read(bottomNavProvider.notifier).state = 4;
                        }
                      }, 
                      child:  const Icon(Icons.menu, color: Colors.white,),
                      itemBuilder: (context) {
                       return [
                         const PopupMenuItem(
                           value: 0,
                           child: Row(
                             children: [
                               Icon(Icons.login),
                               SizedBox(width: 10,),
                               Text('Login'),
                             ],
                           ),
                         ),
                       ];
                     }),
                  const SizedBox(width: 20,)
                ],
              ) 
        ,
        bottomNavigationBar: isWeb && size.maxWidth > 800
            ? null
            : BottomNavigationBar(onTap: (index) {
                ref.read(bottomNavProvider.notifier).state = index;
                switch (index) {
                  case 0:
                    AutoRouter.of(context).push(const ResourcesRoute());
                    break;
                  case 1:
                    AutoRouter.of(context).push(const MainCoursesRoute());
                    break;
                  case 2:
                    AutoRouter.of(context).push(const MainClassesRoute());
                    break;
                  case 3:
                    AutoRouter.of(context).push(const ChatRoute());
                    break;
                  case 4:
                    AutoRouter.of(context).push(const LoginRoute());
                    break;
                }
            },
                currentIndex: ref.watch(bottomNavProvider),
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
             items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_books), label: 'Material'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list,
                    ),
                    label: 'Courses'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.school,
                    ),
                    label: 'Classroom'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message), label: 'Chat'),
              ]),
      );
    });
  }
}
