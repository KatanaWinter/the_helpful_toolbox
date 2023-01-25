import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_helpful_toolbox/data/models/CompanyModel.dart';
import 'package:the_helpful_toolbox/data/models/EmployeeModel.dart';
import 'package:the_helpful_toolbox/features/company/company_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EmployeeCreateDialog extends StatefulWidget {
  Company company;
  EmployeeCreateDialog({required this.company, super.key});

  @override
  State<EmployeeCreateDialog> createState() => _EmployeeCreateDialogState();
}

class _EmployeeCreateDialogState extends State<EmployeeCreateDialog> {
  final _formKey = GlobalKey<FormState>();
  final Employee _employee = Employee();

  @override
  void initState() {
    super.initState();
    _employee.companyId = widget.company.id;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Employee Data'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: isSmallScreen(context)
                          ? getScreenWidth(context)
                          : getScreenWidth(context) * 0.4,
                      height: getScreenHeight(context),
                      child: FocusScope(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Firstname'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _employee.firstname = value;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Lastname'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _employee.lastname = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Phone'),
                                initialValue: _employee.phone,
                                onChanged: (val) => setState(() {
                                  _employee.phone = val;
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Mobile'),
                                initialValue: _employee.mobile,
                                onChanged: (val) => setState(() {
                                  _employee.mobile = val;
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email'),
                                initialValue: _employee.email,
                                onChanged: (val) => setState(() {
                                  _employee.email = val;
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("Birthdate:"),
                                    Text(_employee.birthdate == null
                                        ? ""
                                        : DateFormat.yMMMEd()
                                            .format(_employee.birthdate!)),
                                    const Spacer(),
                                    ElevatedButton(
                                        onPressed: _pickDateDialog,
                                        child: const Text('Pick Birthdate'))
                                  ],
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Cancel'),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Save'),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      saveEmployeeDataDialog(
                                          context, _employee);
                                    } else {}
                                    // Hier passiert etwas anderes
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime(
                2100)) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _employee.birthdate = pickedDate;
      });
    });
  }

  saveEmployeeDataDialog(context, Employee employee) async {
    bool stored = await employee.employeeStore(context);
    stored == true
        ? debugPrint("save employee to Database success")
        : debugPrint("save employee to Database failed");

    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CompanyPage()));
  }
}
