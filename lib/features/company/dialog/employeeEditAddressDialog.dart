import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/data/models/EmployeeModel.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';
import 'package:the_helpful_toolbox/features/company/show/employee_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EmployeeEditAddressDialog extends StatefulWidget {
  Employee employee;
  EmployeeEditAddressDialog({required this.employee, super.key});

  @override
  State<EmployeeEditAddressDialog> createState() =>
      _EmployeeEditAddressDialogState();
}

class _EmployeeEditAddressDialogState extends State<EmployeeEditAddressDialog> {
  final _formKey = GlobalKey<FormState>();
  Property _propertie = Property(
      name: "",
      street: "",
      street2: "",
      city: "",
      state: "",
      postalcode: "",
      country: "");

  @override
  void initState() {
    // TODO: implement initState

    widget.employee.propertieId != null
        ? _propertie.id = widget.employee.propertieId!
        : "";
    if (widget.employee.propertie != null) {
      _propertie = widget.employee.propertie!;
    }
  }

  @override
  Widget build(BuildContext context) {
    _propertie.active = 1;
    _propertie.name =
        "${widget.employee.firstname} ${widget.employee.lastname} - Property";
    return AlertDialog(
      title: const Text('Edit Property'),
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
                                    labelText: 'Name'),
                                initialValue: _propertie.name,
                                enabled: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street'),
                                initialValue: _propertie.street,
                                onChanged: (val) => setState(() {
                                  _propertie.street = val;
                                }),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street 2'),
                                initialValue: _propertie.street2,
                                onChanged: (val) => setState(() {
                                  _propertie.street2 = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'City'),
                                initialValue: _propertie.city,
                                onChanged: (val) => setState(() {
                                  _propertie.city = val;
                                }),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'State'),
                                initialValue: _propertie.state,
                                onChanged: (val) => setState(() {
                                  _propertie.state = val;
                                }),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Postal Code'),
                                initialValue: _propertie.postalcode,
                                onChanged: (val) => setState(() {
                                  _propertie.postalcode = val;
                                }),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
                                      // Hier passiert etwas
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
                                      savePropertyForEmployee(
                                          context, widget.employee, _propertie);
                                    } else {
                                      print('Error');
                                    }
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

  savePropertyForEmployee(
      context, Employee _employee, Property _property) async {
    debugPrint("save billing address to Database start");
    if (_employee.propertie == null) {
      Property stored = await _property.propertyStore(context);
      if (stored != null) {
        ("save billing address to Database success");
        _employee.propertieId = stored.id;
        _employee.employeeUpdate(context);
      } else {
        debugPrint("save billing address to Database failed");
      }
    } else {
      bool stored = await _property.propertyUpdate(context);
      stored == true
          ? debugPrint("save billing address to Database success")
          : debugPrint("save billing address to Database failed");
    }
    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EmployeePage(_employee)));
  }
}
