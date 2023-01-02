import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/data/models/BillingAddressModel.dart';
import 'package:the_helpful_toolbox/data/models/CompanyModel.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';
import 'package:the_helpful_toolbox/features/company/company_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EditCompanyDataDialog extends StatefulWidget {
  Company company;
  EditCompanyDataDialog({required this.company, super.key});

  @override
  State<EditCompanyDataDialog> createState() => _EditCompanyDataDialogState();
}

class _EditCompanyDataDialogState extends State<EditCompanyDataDialog> {
  final _formKey = GlobalKey<FormState>();
  Company _company = Company();

  @override
  void initState() {
    // TODO: implement initState

    widget.company != null ? _company = widget.company : "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Company Data'),
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
                                initialValue: _company.name,
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
                                    labelText: 'Phone'),
                                initialValue: _company.phone,
                                onChanged: (val) => setState(() {
                                  _company.phone = val;
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
                                    labelText: 'Mobile'),
                                initialValue: _company.mobile,
                                onChanged: (val) => setState(() {
                                  _company.mobile = val;
                                }),
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
                                      saveCompanyDataDialog(context, _company);
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

  saveCompanyDataDialog(context, Company _company) async {
    if (_company == null) {
      bool stored = await _company.companieStore(context);
      stored == true
          ? debugPrint("save company data to Database success")
          : debugPrint("save company data to Database failed");
    } else {
      bool stored = await _company.companyUpdate(context);
      stored == true
          ? debugPrint("save company data to Database success")
          : debugPrint("save company data to Database failed");
    }
    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CompanyPage()));
  }
}
