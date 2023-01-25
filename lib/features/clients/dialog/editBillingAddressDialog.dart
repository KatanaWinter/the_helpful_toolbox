import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/BillingAddressModel.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/features/clients/show/client_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EditBillingAddressDialog extends StatefulWidget {
  Client client;
  EditBillingAddressDialog({required this.client, super.key});

  @override
  State<EditBillingAddressDialog> createState() =>
      _EditBillingAddressDialogState();
}

class _EditBillingAddressDialogState extends State<EditBillingAddressDialog> {
  final _formKey = GlobalKey<FormState>();
  BillingAddress _billingAddress = BillingAddress(
      clientId: 1,
      name: "",
      street: "",
      street2: "",
      city: "",
      state: "",
      postalcode: "",
      country: "");

  @override
  void initState() {
    super.initState();

    widget.client.billingAddress != null
        ? _billingAddress = widget.client.billingAddress!
        : "";
  }

  @override
  Widget build(BuildContext context) {
    _billingAddress.clientId = widget.client.id;
    _billingAddress.active = 1;
    _billingAddress.name = "Billing Address";
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
                                initialValue: _billingAddress.name,
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
                                initialValue: _billingAddress.street,
                                onChanged: (val) => setState(() {
                                  _billingAddress.street = val;
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
                                initialValue: _billingAddress.street2,
                                onChanged: (val) => setState(() {
                                  _billingAddress.street2 = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'City'),
                                initialValue: _billingAddress.city,
                                onChanged: (val) => setState(() {
                                  _billingAddress.city = val;
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
                                initialValue: _billingAddress.state,
                                onChanged: (val) => setState(() {
                                  _billingAddress.state = val;
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
                                initialValue: _billingAddress.postalcode,
                                onChanged: (val) => setState(() {
                                  _billingAddress.postalcode = val;
                                }),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
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
                                      saveBillingAddressForClient(context,
                                          widget.client, _billingAddress);
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

  saveBillingAddressForClient(
      context, Client client, BillingAddress billingAddress) async {
    debugPrint("save billing address to Database start");
    billingAddress.clientId = client.id;
    if (client.billingAddress == null) {
      bool stored = await billingAddress.billingAddressStore(context);
      stored == true
          ? debugPrint("save billing address to Database success")
          : debugPrint("save billing address to Database failed");
    } else {
      bool stored = await billingAddress.billingAddressUpdate(context);
      stored == true
          ? debugPrint("save billing address to Database success")
          : debugPrint("save billing address to Database failed");
    }
    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ClientPage(client)));
  }
}
