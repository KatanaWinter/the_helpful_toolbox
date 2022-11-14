import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/clients_page.dart';
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
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street'),
                                initialValue: _billingAddress.street,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street 2'),
                                initialValue: _billingAddress.street2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'City'),
                                initialValue: _billingAddress.city,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'State'),
                                initialValue: _billingAddress.state,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Postal Code'),
                                initialValue: _billingAddress.postalcode,
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
