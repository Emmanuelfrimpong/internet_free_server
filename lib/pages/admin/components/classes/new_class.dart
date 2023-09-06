import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NewClassScreen extends StatefulWidget {
  const NewClassScreen({super.key});

  @override
  State<NewClassScreen> createState() => _NewClassScreenState();
}

class _NewClassScreenState extends State<NewClassScreen> {
  @override
  Widget build(BuildContext context) {
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
            Card(
                elevation: 2,
                child: Container(
                  width: size.maxWidth * 0.55,
                  padding: const EdgeInsets.all(25),
                ))
          ]));
    });
  }
}

