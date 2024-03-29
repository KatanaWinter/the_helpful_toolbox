import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/EmployeeModel.dart';
import 'package:the_helpful_toolbox/features/clients/dialog/newClientDialog.dart';
import 'package:the_helpful_toolbox/features/company/company_page.dart';
import 'package:the_helpful_toolbox/features/company/dialog/EmployeeEditDialog.dart';
import 'package:the_helpful_toolbox/features/company/show/employee_address_card.dart';
import 'package:the_helpful_toolbox/features/company/show/employee_contact_data.dart';
import 'package:the_helpful_toolbox/features/media/displayMediaList.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EmployeePage extends StatefulWidget {
  Employee employee;
  EmployeePage(this.employee, {super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  Future<Employee>? dataLoaded;
  Employee _employee = Employee();
  @override
  void initState() {
    super.initState();
    _employee = widget.employee;

    dataLoaded = _getData();
  }

  Future<Employee> _getData() async {
    Employee employee = await _employee.employeeShow(context);
    return employee;
  }

  @override
  Widget build(BuildContext context) {
    Employee employee = _employee;
    double contentWidth = getContentWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${employee.firstname} ${employee.lastname}"),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarNavigation(),
            SingleChildScrollView(
              child: SizedBox(
                width: contentWidth,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: buildAsyncList(context, employee)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildAsyncList(context, client) {
    return FutureBuilder(
        future: dataLoaded,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              Employee employee = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CompanyPage()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Back to Company"),
                          )),
                      const Spacer(),
                      ButtonBar(children: [
                        IconButton(
                            onPressed: () {
                              openEditEmployeeDialog(context, employee);
                            },
                            icon: const Icon(Icons.edit)),
                      ]),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: [
                      Column(
                        children: [
                          EmployeeContactDataCard(employee),
                        ],
                      ),
                      EmployeeAddressCard(employee),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      employee.media == null
                          ? const Text("")
                          : SizedBox(
                              width: 600,
                              child: DisplayMediaList(
                                lMedia: employee.media!,
                                whereToUpload: "employee/${employee.id}",
                                lastScreen: EmployeePage(employee),
                              ))
                    ],
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        });
  }

  openNewClientDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NewClientDialog();
      },
    );
  }

  openEditEmployeeDialog(context, Employee employee) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmployeeEditDialog(
          employee: employee,
          backPage: EmployeePage(employee),
        );
      },
    );
  }
}
