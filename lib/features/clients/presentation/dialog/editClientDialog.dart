import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
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
  Property billingAddress = Property(
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
    super.initState();
  }

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
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email'),
                                initialValue: widget.client.email,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
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
                            const Text("Property:"),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name'),
                                initialValue: billingAddress.name,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street'),
                                initialValue: billingAddress.street,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street 2'),
                                initialValue: billingAddress.street2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'City'),
                                initialValue: billingAddress.city,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'State'),
                                initialValue: billingAddress.state,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Postal Code'),
                                initialValue: billingAddress.postalcode,
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
            saveClientWithProperty(context);
            // Hier passiert etwas anderes
          },
        ),
      ],
    );
  }

  saveClientWithProperty(context) {
    debugPrint("edit client to Database");
    Navigator.of(context).pop();
  }
}
