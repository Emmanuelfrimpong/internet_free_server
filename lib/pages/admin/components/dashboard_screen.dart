import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/state/instructors_state.dart';
import 'package:internet_free_server/state/student_state.dart';
import 'package:internet_free_server/styles/colors.dart';
import '../../../state/classes_state.dart';
import '../../../state/material_state.dart';
import '../widgets/dashboard_item.dart';

@RoutePage()
class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});
  @override
  ConsumerState<DashBoardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    var studentsList = ref.watch(studentsFuture);
    var materialsList = ref.watch(materialFutureProvider);
    var instructorsList = ref.watch(instructorFutureProvider);
    var classesList = ref.watch(classDataFutureProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Dashboard'.toUpperCase(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                studentsList.when(
                  data: (data) {
                    return DashboardItem(
                      title: 'Total Students',
                      value: data.length.toDouble(),
                      color: Colors.red,
                      icon: Icons.group,
                    );
                  },
                  loading: () => const DashboardItem(
                    loading: true,
                    color: Colors.red,
                  ),
                  error: (error, stack) => const DashboardItem(
                    error: true,
                    color: Colors.red,
                  ),
                ),
                materialsList.when(
                  data: (data) {
                    return DashboardItem(
                      title: 'Total Materials',
                      value: data.length.toDouble(),
                      color: Colors.blue,
                      icon: Icons.library_books,
                    );
                  },
                  loading: () => const DashboardItem(
                    loading: true,
                    color: Colors.blue,
                  ),
                  error: (error, stack) => const DashboardItem(
                    error: true,
                    color: Colors.blue,
                  ),
                ),
                instructorsList.when(
                  data: (data) {
                    return DashboardItem(
                      title: 'Total Instructors',
                      value: data.length.toDouble(),
                      color: Colors.green,
                      icon: Icons.person,
                    );
                  },
                  loading: () => const DashboardItem(
                    loading: true,
                    color: Colors.green,
                  ),
                  error: (error, stack) => const DashboardItem(
                    error: true,
                    color: Colors.green,
                  ),
                ),
                classesList.when(
                  data: (data) {
                    return DashboardItem(
                      title: 'Total Classes',
                      value: data.length.toDouble(),
                      color: primaryColor,
                      icon: Icons.meeting_room,
                    );
                  },
                  loading: () => const DashboardItem(
                    loading: true,
                    color: Colors.green,
                  ),
                  error: (error, stack) => const DashboardItem(
                    error: true,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Divider(
              color: primaryColor,
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 400,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Active Users'.toUpperCase(),
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      studentsList.when(
                        data: (data) {
                          var onlineStudents = data
                              .where((element) => element.isOnline == true)
                              .toList();
                          if (onlineStudents.isEmpty) {
                            return const Center(
                                child: Text(
                              'No Students Online',
                              style: TextStyle(color: Colors.grey),
                            ));
                          }
                          return Expanded(
                            child: DataTable2(
                              columnSpacing: 15,
                              horizontalMargin: 12,
                              minWidth: 600,
                              empty: const Center(
                                  child: Text(
                                'No User Online at the moment',
                                style: TextStyle(color: Colors.grey),
                              )),
                              columns: [
                                'Image',
                                'Index Number',
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
                                            fontWeight: FontWeight.bold),
                                      )))
                                  .toList(),
                              rows: onlineStudents
                                  .map((e) => DataRow(cells: [
                                        if (e.profileUrl != null &&
                                            e.profileUrl!.isNotEmpty)
                                          DataCell(Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(e.profileUrl!),
                                              radius: 30,
                                            ),
                                          ))
                                        else
                                          DataCell(Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 30,
                                              child: Text(e.name!
                                                  .substring(0, 1)
                                                  .toUpperCase()),
                                            ),
                                          )),
                                        DataCell(Text(e.indexNumber ?? '',style: TextStyle(color: primaryColor),)),
                                        DataCell(Text(e.name ?? '')),
                                        DataCell(Text(e.gender ?? '')),
                                        DataCell(Text(e.email ?? '')),
                                        DataCell(Text(e.phoneNumber ?? '')),
                                        DataCell(Text(e.department ?? '')),
                                        DataCell(Text(
                                          e.status ?? '',
                                          style: TextStyle(
                                              color: e.status == 'active'
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataCell(Row(
                                          children: [
                                            // swicting button
                                            Switch(
                                                activeColor: primaryColor,
                                                inactiveThumbColor: Colors.grey,
                                                inactiveTrackColor:
                                                    Colors.grey[300],
                                                value: e.status == 'active',
                                                onChanged: (value) {
                                                  ref
                                                      .read(studentsDataProvider
                                                          .notifier)
                                                      .updateStudentStatus(
                                                          e.copyWith(
                                                              status: value
                                                                  ? 'active'
                                                                  : 'disabled'),
                                                          ref);
                                                }),
                                          ],
                                        )),
                                      ]))
                                  .toList(),
                            ),
                          );
                        },
                        error: (e, s) {
                          return const Center(
                              child: Text('Something went wrong'));
                        },
                        loading: () => const Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()),
                        ),
                      )
                    ],
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
