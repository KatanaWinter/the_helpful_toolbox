import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/clients_page.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/show/client_page.dart';
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

  @override
  Widget build(BuildContext context) {
    Property _billingAddress = Property(
        clientId: 1,
        name: "",
        street: "",
        city: "",
        state: "",
        postalcode: "",
        country: "");
    _billingAddress = widget.client.billingAddress!;

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
            saveBillingAddressForClient(
                context, widget.client, _billingAddress);
            // Hier passiert etwas anderes
          },
        ),
      ],
    );
  }

  saveBillingAddressForClient(
      context, Client _client, Property billingAddress) async {
    debugPrint("save billing address to Database");
    billingAddress.clientId = _client.id;
    if (_client.billingAddressId == -1) {
      http.Response? _property =
          await billingAddress.saveProperty(billingAddress);
    } else {
      http.Response? _property =
          await billingAddress.updateProperty(billingAddress);
    }
    // _client.billingAddressId = _property.id;
    // await _client.updateClient(_client);
    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ClientPage(_client)));
  }
}
