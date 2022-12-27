import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/BillingAddressModel.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';
import 'package:the_helpful_toolbox/features/clients/clients_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EditClientDialog extends StatefulWidget {
  Client client;
  EditClientDialog(this.client, {super.key});

  @override
  State<EditClientDialog> createState() => _EditClientDialogState();
}

class _EditClientDialogState extends State<EditClientDialog> {
  final _formKey = GlobalKey<FormState>();
  Client _client = Client(
    id: 1,
    title: "",
    firstname: "Kevin Winter",
    lastname: "Winter",
    mobilenumber: "",
    phonenumber: "",
    email: "kcgwinter@t-online.de",
    rating: 5,
    active: 1,
    properties: [],
  );
  BillingAddress billingAddress = BillingAddress(
    city: '',
    clientId: 1,
    country: '',
    name: '',
    postalcode: '',
    state: '',
    street: '',
  );

  @override
  void initState() {
    // billingAddress = _client.getBillingAddress(_client);
    _client = widget.client;
    // billingAddress = widget.client.billingAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Client'),
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
                                initialValue: widget.client.firstname,
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
                                initialValue: widget.client.lastname,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Company name'),
                                initialValue: "",
                                onChanged: (val) => setState(() {
                                  // _client.c = val;
                                }),
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
                                initialValue: widget.client.phonenumber,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Mobile number'),
                                initialValue: widget.client.mobilenumber,
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
                                initialValue: widget.client.email,
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
            saveClientWithProperty(context, _client);
            // Hier passiert etwas anderes
          },
        ),
      ],
    );
  }

  saveClientWithProperty(context, Client client) async {
    debugPrint("save client to Database");
    client.billingAddress = billingAddress;
    await client.updateClient(client, context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ClientsPage()));
  }
}
