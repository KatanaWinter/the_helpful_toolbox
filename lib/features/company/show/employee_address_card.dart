import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/EmployeeModel.dart';
import 'package:the_helpful_toolbox/features/clients/dialog/editBillingAddressDialog.dart';
import 'package:the_helpful_toolbox/features/company/dialog/employeeEditAddressDialog.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EmployeeAddressCard extends StatefulWidget {
  Employee employee;
  EmployeeAddressCard(this.employee, {super.key});

  @override
  State<EmployeeAddressCard> createState() => _EmployeeAddressCardState();
}

class _EmployeeAddressCardState extends State<EmployeeAddressCard> {
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
                    AutoSizeText(
                      'Address',
                      style: TextStyle(fontSize: 20),
                      maxLines: 3,
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
                    Spacer(),
                    Column(
                      children: [
                        AutoSizeText(
                          "${widget.employee.propertie?.street ?? ""}",
                          style: TextStyle(fontSize: 18),
                          maxLines: 3,
                        ),
                        AutoSizeText(
                          "${widget.employee.propertie?.city ?? ""} , ${widget.employee.propertie?.state ?? ""} ${widget.employee.propertie?.postalcode ?? ""}",
                          style: TextStyle(fontSize: 18),
                          maxLines: 3,
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          openEditPropertyDialog(context, widget.employee);
                        },
                        icon: Icon(Icons.edit))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  openEditPropertyDialog(context, Employee _employee) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmployeeEditAddressDialog(employee: _employee);
      },
    );
  }
}
