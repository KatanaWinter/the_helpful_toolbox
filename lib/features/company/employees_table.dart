import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/EmployeeModel.dart';

class EmployeesTable extends StatefulWidget {
  late List<Employee> lEmployee;
  EmployeesTable(this.lEmployee, {super.key});

  @override
  State<EmployeesTable> createState() => _EmployeesTableState();
}

class _EmployeesTableState extends State<EmployeesTable> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
        Container(
          height: 200,
          width: 500,
          child: ListView.builder(
              itemCount: widget.lEmployee.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.lEmployee[index].firstname ?? ""),
                );
              }),
        ),
      ],
    );
  }
}
