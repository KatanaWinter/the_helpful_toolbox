import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_helpful_toolbox/data/models/EmployeeModel.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EmployeeContactDataCard extends StatelessWidget {
  Employee employee;
  EmployeeContactDataCard(this.employee, {super.key});

  @override
  Widget build(BuildContext context) {
    double contentWidth = getContentWidth(context);
    return Card(
        elevation: 10,
        color: ThemeData.dark().cardColor,
        child: SizedBox(
          width: isSmallScreen(context) ? contentWidth : contentWidth * 0.45,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Contact Data',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Name:"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Phone:"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Mobile:"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Email:"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Birthdate:"),
                          ]),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                              "${employee.firstname} ${employee.lastname}"),
                          const SizedBox(
                            height: 10,
                          ),
                          SelectableText(employee.phone ?? ""),
                          const SizedBox(
                            height: 10,
                          ),
                          SelectableText(employee.mobile ?? ""),
                          const SizedBox(
                            height: 10,
                          ),
                          SelectableText(employee.email ?? ""),
                          const SizedBox(
                            height: 10,
                          ),
                          SelectableText(
                              DateFormat.yMMMd().format(employee.birthdate!)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
