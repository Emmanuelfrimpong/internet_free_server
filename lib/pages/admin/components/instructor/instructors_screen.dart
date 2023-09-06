import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/config/routes/routes.dart';
import 'package:internet_free_server/state/instructors_state.dart';

import '../../../../core/components/widgets/custom_input.dart';
import '../../../../styles/colors.dart';

@RoutePage()
class InstructorsScreen extends ConsumerStatefulWidget {
  const InstructorsScreen({super.key});

  @override
  ConsumerState<InstructorsScreen> createState() => _InstructorsScreenState();
}

class _InstructorsScreenState extends ConsumerState<InstructorsScreen> {
  @override
  Widget build(BuildContext context) {
   var instructors = ref.watch(instructorFutureProvider);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Registered Students'.toUpperCase(),
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
                      hintText: 'Search Instructor',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(width: 20),
                  
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 22)),
                      onPressed: () {
                        AutoRouter.of(context).push(const NewInstructorRoute());
                      },
                      child: const Text(
                        "New Instructor",
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

          Expanded(
            child: instructors.when(data: (data) {
              if (data.isEmpty) {
                return const Center(child: Text('No Instructor Found'));
              } else {
                return DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                   dataRowHeight: 50,
                    columns: [
                      'Image',
                      'ID',
                      'Name',
                      'Gender',
                      'Email',
                      'Phone Number',
                      'Department',
                       'Status',
                      'Action',
                    ]
                        .map((e) => DataColumn(
                                label: Text(
                              e,
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )))
                        .toList(),
                    rows: data
                        .map((e) => DataRow(cells: [
                              if (e.profileUrl != null &&
                                  e.profileUrl!.isNotEmpty)
                                DataCell(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(e.profileUrl!),
                                    radius: 30,
                                  ),
                                ))
                              else
                                DataCell(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: Text(
                                        e.name!.substring(0, 1).toUpperCase()),
                                  ),
                                )),
                              DataCell(Text(e.id ?? '')),
                              DataCell(Text(e.name ?? '')),
                              DataCell(Text(e.gender ?? '')),
                              DataCell(Text(e.email ?? '')),
                              DataCell(Text(e.phoneNumber ?? '')),
                              DataCell(Text(e.department ?? '')),
                               DataCell(Text(e.status ?? '',style: TextStyle(
                                  color: e.status == 'active' ? Colors.green : Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                               ),)),
                              DataCell(Row(
                                children: [
                                  // swicting button
                                  Switch(
                                      activeColor: primaryColor,
                                      inactiveThumbColor: Colors.grey,
                                      inactiveTrackColor: Colors.grey[300],
                                      value: e.status == 'active',
                                      onChanged: (value) {
                                        ref
                                            .read(instructorDataProvider.notifier)
                                            .updateStudentStatus(
                                                e.copyWith(
                                                    status: value
                                                        ? 'active'
                                                        : 'disabled'),ref);
                                      }),
                                ],
                              )),
                            ]))
                        .toList());
              }
            }, error: (e, s) {
              return Center(child: Text(e.toString()));
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }),
          )
          
        ],
      ),
    );
  }
}