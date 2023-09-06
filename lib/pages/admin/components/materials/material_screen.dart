import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/components/widgets/custom_input.dart';
import '../../../../state/material_state.dart';
import '../../../../styles/colors.dart';

@RoutePage()
class MaterialsScreen extends ConsumerStatefulWidget {
  const MaterialsScreen({super.key});

  @override
  ConsumerState<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends ConsumerState<MaterialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
         Row(
            children: [
              Text('Uploded Material'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  const SizedBox(
                    width: 450,
                    child: CustomTextFields(
                      hintText: 'Search materials',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 22)),
                      onPressed: () {
                       AutoRouter.of(context).push(const NewMaterialRoute());
                      },
                      child: const Text(
                        "Upload Material",
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(width: 10),
                ],
              ))
            ],
          ),
          const Divider(
            color: primaryColor,
            thickness: 2,
            height: 20,
          ),

        ],
      ),
    );
  
  }
}