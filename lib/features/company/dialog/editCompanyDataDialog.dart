import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/CompanyModel.dart';
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

  @override
  void initState() {
    super.initState();
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
                                initialValue: widget.company.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  widget.company.name = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Phone'),
                                initialValue: widget.company.phone,
                                onChanged: (val) => setState(() {
                                  widget.company.phone = val;
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
                                initialValue: widget.company.mobile,
                                onChanged: (val) => setState(() {
                                  widget.company.mobile = val;
                                }),
                              ),
                            ),
                            const SizedBox(
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
                                      saveCompanyDataDialog(
                                          context, widget.company);
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

  saveCompanyDataDialog(context, Company company) async {
    if (company == null) {
      bool stored = await company.companieStore(context);
      stored == true
          ? debugPrint("save company data to Database success")
          : debugPrint("save company data to Database failed");
    } else {
      bool stored = await company.companyUpdate(context);
      stored == true
          ? debugPrint("save company data to Database success")
          : debugPrint("save company data to Database failed");
    }
    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CompanyPage()));
  }
}
