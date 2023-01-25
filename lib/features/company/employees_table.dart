import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_helpful_toolbox/data/models/CompanyModel.dart';
import 'package:the_helpful_toolbox/data/models/EmployeeModel.dart';
import 'package:the_helpful_toolbox/features/company/company_page.dart';
import 'package:the_helpful_toolbox/features/company/dialog/EmployeeEditDialog.dart';
import 'package:the_helpful_toolbox/features/company/show/employee_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EmployeesTable extends StatefulWidget {
  late List<Employee> lEmployee;
  Company company;
  EmployeesTable(this.lEmployee, this.company, {super.key});

  @override
  State<EmployeesTable> createState() => _EmployeesTableState();
}

class _EmployeesTableState extends State<EmployeesTable> {
  TextEditingController searchController = TextEditingController();
  List<Employee> lEmployee = [];
  List<Employee> lFilteredEmployee = [];

  @override
  void initState() {
    super.initState();
    lEmployee = widget.lEmployee;
    lFilteredEmployee = lEmployee;
  }

  @override
  Widget build(BuildContext context) {
    double contentWidth = getContentWidth(context);

    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: isSmallScreen(context)
                      ? contentWidth - 60
                      : contentWidth / 2 - 50,
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Search for ...',
                    ),
                    onChanged: (val) {
                      setState(() {
                        String searchVal = val.toLowerCase();
                        lFilteredEmployee = lEmployee
                            .where((e) =>
                                e.firstname!
                                    .toLowerCase()
                                    .contains(searchVal) ||
                                e.lastname!.toLowerCase().contains(searchVal))
                            .toList();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [buildList(context, lFilteredEmployee)],
            ),
          )
        ],
      ),
    );
  }

  buildList(BuildContext context, List<Employee> lFilteredEmployee) {
    double tableWidth = getScreenWidth(context);
    NumberFormat formatter = NumberFormat("000000");
    isSmallScreen(context)
        ? tableWidth = tableWidth - 100
        : tableWidth = tableWidth / 2 - 250;

    return lEmployee.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: lFilteredEmployee.length,
              itemBuilder: ((context, index) {
                Employee employee = lFilteredEmployee[index];
                return SizedBox(
                  width: tableWidth,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: tableWidth * 0.1,
                            height: 50,
                            child: AutoSizeText(
                                textAlign: TextAlign.start,
                                "#${formatter.format(employee.id!)}"),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: tableWidth * 0.15,
                            height: 50,
                            child: AutoSizeText(
                                "${employee.firstname ?? ""} ${employee.lastname ?? ""}"),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: isSmallScreen(context)
                                ? tableWidth * 0.4
                                : tableWidth * 0.5,
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AutoSizeText("Phone: ${employee.phone ?? ""} "),
                                AutoSizeText(
                                    "Mobile: ${employee.mobile ?? ""}"),
                                AutoSizeText(
                                    maxLines: 2,
                                    "Email: ${employee.email ?? ""}"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ButtonBar(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showEmployee(context, employee);
                                    },
                                    icon: const Icon(Icons.open_in_new)),
                                IconButton(
                                    onPressed: () {
                                      openEditEmployeeDialog(
                                          context, widget.company, employee);
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      employee.employeeDelete(context);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CompanyPage()));
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 10,
                      )
                    ],
                  ),
                );
              }),
            ),
          );
  }

  openEditEmployeeDialog(context, Company company, Employee employee) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmployeeEditDialog(
            employee: employee, backPage: const CompanyPage());
      },
    );
  }

  showEmployee(context, Employee employee) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EmployeePage(employee)));
  }
}
