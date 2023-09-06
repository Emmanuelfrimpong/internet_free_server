import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:internet_free_server/generated/assets.dart';
import 'package:internet_free_server/styles/colors.dart';

import 'widgets/side_bar.dart';

@RoutePage()
class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      if (size.maxWidth >= 1200) {
        return const Scaffold(
            body: Row(
          children: [
            SideBar(),
            Expanded(
              flex: 5,
              child: AutoRouter(),
            ),
          ],
        ));
      } else {
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            title: Row(
              children: [
                // logo
                const SizedBox(width: 5),
                Image.asset(
                  Assets.logos2,
                  height: 40,
                ),
                const SizedBox(width: 20),
                const Text(
                  'IFS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
            drawer: const SideBar(),
            body: const AutoRouter());
      }
    });
  }
}
