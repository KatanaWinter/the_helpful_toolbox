import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/data/models/BillingAddressModel.dart';
import 'package:the_helpful_toolbox/data/models/CompanyModel.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';
import 'package:the_helpful_toolbox/features/company/company_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EditCompanyAddressDialog extends StatefulWidget {
  Company company;
  EditCompanyAddressDialog({required this.company, super.key});

  @override
  State<EditCompanyAddressDialog> createState() =>
      _EditCompanyAddressDialogState();
}

class _EditCompanyAddressDialogState extends State<EditCompanyAddressDialog> {
  final _formKey = GlobalKey<FormState>();
  Property _companyAddress = Property(
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

    widget.company.propertie != null
        ? _companyAddress = widget.company.propertie!
        : "";
  }

  @override
  Widget build(BuildContext context) {
    _companyAddress.active = 1;
    _companyAddress.name = "Company Address";
    return AlertDialog(
      title: const Text('Edit Company Address'),
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
                                initialValue: _companyAddress.name,
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
                                initialValue: _companyAddress.street,
                                onChanged: (val) => setState(() {
                                  _companyAddress.street = val;
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
                                initialValue: _companyAddress.street2,
                                onChanged: (val) => setState(() {
                                  _companyAddress.street2 = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'City'),
                                initialValue: _companyAddress.city,
                                onChanged: (val) => setState(() {
                                  _companyAddress.city = val;
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
                                initialValue: _companyAddress.state,
                                onChanged: (val) => setState(() {
                                  _companyAddress.state = val;
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
                                initialValue: _companyAddress.postalcode,
                                onChanged: (val) => setState(() {
                                  _companyAddress.postalcode = val;
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
                                      saveCompanyAddressDialog(context,
                                          widget.company, _companyAddress);
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

  saveCompanyAddressDialog(
      context, Company _company, Property propertie) async {
    debugPrint("save company address to Database start");
    if (_company.propertie == null) {
      Property stored = await propertie.propertyStore(context);
      stored == true
          ? debugPrint("save company address to Database success")
          : debugPrint("save company address to Database failed");
    } else {
      bool stored = await propertie.propertyUpdate(context);
      stored == true
          ? debugPrint("save company address to Database success")
          : debugPrint("save company address to Database failed");
    }
    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CompanyPage()));
  }
}
