import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/EmployeeModel.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EmployeesTable extends StatefulWidget {
  late List<Employee> lEmployee;
  EmployeesTable(this.lEmployee, {super.key});

  @override
  State<EmployeesTable> createState() => _EmployeesTableState();
}

class _EmployeesTableState extends State<EmployeesTable> {
  TextEditingController searchController = TextEditingController();
  List<Employee> lEmployee = [];
  List<Employee> lFilteredEmployee = [];
  String _searchResult = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lEmployee = widget.lEmployee;
    lFilteredEmployee = lEmployee;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 500,
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
                  _searchResult = val;
                  setState(() {
                    String _searchVal = val.toLowerCase();
                    lFilteredEmployee = lEmployee
                        .where((e) =>
                            e.firstname!.toLowerCase().contains(_searchVal) ||
                            e.lastname!.toLowerCase().contains(_searchVal) ||
                            e.email!.toLowerCase().contains(_searchVal))
                        .toList();
                  });
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  // openNewClientDialog(context);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green[800])),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                  child: Text("New Employee"),
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // buildList(context, lFilteredEmployee)
            ],
          ),
        )
      ],
    );
  }

  buildList(BuildContext context, List<Employee> lFilteredEmployee) {
    double tableWidth = getScreenWidth(context);
    isSmallScreen(context)
        ? tableWidth = tableWidth - 100
        : tableWidth = tableWidth - 250;

    return lEmployee.length <= 0
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: lFilteredEmployee.length,
            itemBuilder: ((context, index) {
              Employee employee = lFilteredEmployee[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: tableWidth * 0.2,
                        height: 20,
                        child: Text(
                            "${employee.firstname!} ${employee.lastname!}"),
                      )
                    ],
                  )
                ],
              );
            }),
          );
  }
}
