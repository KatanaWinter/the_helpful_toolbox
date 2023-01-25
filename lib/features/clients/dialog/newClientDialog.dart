import 'dart:io';

import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/BillingAddressModel.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/features/clients/clients_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class NewClientDialog extends StatefulWidget {
  const NewClientDialog({super.key});

  @override
  State<NewClientDialog> createState() => _NewClientDialogState();
}

class _NewClientDialogState extends State<NewClientDialog> {
  final _formKey = GlobalKey<FormState>();
  final Client _client = Client(
    id: 1,
    title: "",
    firstname: "",
    lastname: "",
    mobilenumber: "",
    phonenumber: "",
    email: "",
    rating: 5,
    active: 1,
    properties: [],
  );

  final BillingAddress _billingAddress = BillingAddress(
      clientId: 1,
      name: "",
      street: "",
      city: "",
      state: "",
      postalcode: "",
      country: "");

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Client'),
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
                            const Text("Client:"),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'First name'),
                                onChanged: (val) => setState(() {
                                  _client.firstname = val;
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
                                    labelText: 'Last name'),
                                onChanged: (val) => setState(() {
                                  _client.lastname = val;
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
                                    labelText: 'Company name'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Phone number'),
                                onChanged: (val) => setState(() {
                                  _client.phonenumber = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Mobile number'),
                                onChanged: (val) => setState(() {
                                  _client.mobilenumber = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email'),
                                onChanged: (val) => setState(() {
                                  _client.email = val;
                                }),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
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
              saveClientWithProperty(context, _client, _billingAddress);
            } else {}
            // Hier passiert etwas anderes
          },
        ),
      ],
    );
  }

  saveClientWithProperty(
      context, Client client, BillingAddress billingAddress) async {
    debugPrint("save client to Database");
    if (_billingAddress.name!.isNotEmpty) {
      client.billingAddress = _billingAddress;
      await client.saveClient(client, context);
    } else {
      await client.saveClient(client, context);
    }
    sleep(const Duration(seconds: 3));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ClientsPage()));
  }
}
