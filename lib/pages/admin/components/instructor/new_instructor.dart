import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/components/widgets/custom_drop_down.dart';
import '../../../../core/components/widgets/custom_input.dart';
import '../../../../state/new_instructor_state.dart';
import '../../../../styles/colors.dart';

@RoutePage()
class NewInstructorScreen extends ConsumerStatefulWidget {
  const NewInstructorScreen({super.key});

  @override
  ConsumerState<NewInstructorScreen> createState() => _NewInstructorScreenState();
}

class _NewInstructorScreenState extends ConsumerState<NewInstructorScreen> {
  final _formKey = GlobalKey<FormState>();
  final indexNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final autoGenerateIndex = ref.watch(autoGenerateInstructorIdProvider);
    return LayoutBuilder(builder: (context, size) {
      return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(children: [
            const SizedBox(height: 20),
            //close button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                    ),
                    onPressed: () {
                      AutoRouter.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            Expanded(
              child: Card(
                  elevation: 2,
                  child: SizedBox(
                    width: size.maxWidth * 0.55,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: Column(children: [
                          const Text(
                            'New Student',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Please Note that the index number will be used as the password for the student account, which can be changed on first login',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  CustomTextFields(
                                    onSaved: (id) {
                                      ref
                                          .read(newInstructorProvider.notifier)
                                          .setId(id!);
                                    },
                                    controller: indexNumberController,
                                    suffixIcon: autoGenerateIndex.when(
                                        error: (error, stack) =>
                                            const SizedBox(),
                                        loading: () => const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator()),
                                        data: (data) {
                                          return ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            onPressed: () {
                                              if (indexNumberController
                                                  .text.isNotEmpty) {
                                                ref.refresh(
                                                    autoGenerateInstructorIdProvider);
                                                setState(() {
                                                  indexNumberController.text =
                                                      data;
                                                });
                                              }
                                              setState(() {
                                                indexNumberController.text =
                                                    data;
                                              });
                                            },
                                            child: const Text(
                                              'Auto Generate',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }),
                                    label: 'Instructor ID',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter instructor ID';
                                      } else if (value.length != 10) {
                                        return 'instructor ID must be 10 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  CustomTextFields(
                                    onSaved: (name) {
                                      ref
                                          .read(newInstructorProvider.notifier)
                                          .setFullName(name!);
                                    },
                                    label: 'Full Name',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter fullname ';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  CustomDropDown(
                                      onChanged: (gender) {
                                        ref
                                            .read(newInstructorProvider.notifier)
                                            .setGender(gender!);
                                      },
                                      label: 'Instructor Gender',
                                      items: ['Male', 'Female']
                                          .map((e) => DropdownMenuItem(
                                              value: e, child: Text(e)))
                                          .toList()),
                                  const SizedBox(height: 25),
                                  CustomTextFields(
                                    onSaved: (email) {
                                      ref
                                          .read(newInstructorProvider.notifier)
                                          .setEmail(email!);
                                    },
                                    label: 'Email Address',
                                    validator: (value) {
                                      if (value != null &&
                                          value.isNotEmpty &&
                                          RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                              .hasMatch(value)) {
                                        return 'Please enter email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  CustomTextFields(
                                    onSaved: (phone) {
                                      ref
                                          .read(newInstructorProvider.notifier)
                                          .setPhoneNumber(phone!);
                                    },
                                    label: 'Telephone Number',
                                    isDigitOnly: true,
                                    validator: (value) {
                                      if (value != null &&
                                          value.isNotEmpty &&
                                          value.length != 10) {
                                        return 'Enter a valid phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomDropDown(
                                    onChanged: (department) {
                                      ref
                                          .read(newInstructorProvider.notifier)
                                          .setDepartment(department!);
                                    },
                                    items: [
                                      "Information Technology Education",
                                      "Mathematics Education",
                                      "Accounting Studies",
                                      "Management Studies",
                                      "Construction & Wood Technology Education",
                                      "Automotive & Mechnical Technology",
                                      "Electrical & Electronics Technology Education",
                                      "Catering & Hospitality Education",
                                      "Fashion & Textiles Design Education",
                                    ]
                                        .map((e) => DropdownMenuItem(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    label: 'Department',
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 18)),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _formKey.currentState!.save();
                                                  ref
                                                      .read(newInstructorProvider
                                                          .notifier)
                                                      .saveInstructor(
                                                          ref,
                                                          _formKey,
                                                          indexNumberController);
                                                }
                                              },
                                              child: const Text(
                                                'Create',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )))
                                    ],
                                  )
                                ],
                              ))
                        ]),
                      ),
                    ),
                  )),
            )
          ]));
    });
  }
}
