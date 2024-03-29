import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';
import 'package:the_helpful_toolbox/features/clients/show/client_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EditPropertyDialog extends StatefulWidget {
  Property property;
  Client client;
  EditPropertyDialog(this.property, this.client, {super.key});

  @override
  State<EditPropertyDialog> createState() => _EditPropertyDialogState();
}

class _EditPropertyDialogState extends State<EditPropertyDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Property property = widget.property;
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
                                initialValue: property.name,
                                onChanged: (val) => setState(() {
                                  property.name = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street'),
                                initialValue: property.street,
                                onChanged: (val) => setState(() {
                                  property.street = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street 2'),
                                initialValue: property.street2,
                                onChanged: (val) => setState(() {
                                  property.street2 = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'City'),
                                initialValue: property.city,
                                onChanged: (val) => setState(() {
                                  property.city = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'State'),
                                initialValue: property.state,
                                onChanged: (val) => setState(() {
                                  property.state = val;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Postal Code'),
                                initialValue: property.postalcode,
                                onChanged: (val) => setState(() {
                                  property.postalcode = val;
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
            savedEditProperty(context, property);
            // Hier passiert etwas anderes
          },
        ),
      ],
    );
  }

  savedEditProperty(context, Property property) async {
    debugPrint("save property");

    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => ClientPage(_client)));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ClientPage(widget.client)),
      (route) => false,
    );
  }
}
