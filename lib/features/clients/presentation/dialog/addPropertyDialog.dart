import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class AddPropertyDialog extends StatefulWidget {
  Client client;
  AddPropertyDialog(this.client, {super.key});

  @override
  State<AddPropertyDialog> createState() => _AddPropertyDialogState();
}

class _AddPropertyDialogState extends State<AddPropertyDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Property'),
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
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Street 2'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'City'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'State'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Postal Code'),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Cancel'),
            ),
            onPressed: () {
              // Hier passiert etwas
              Navigator.of(context).pop();
            }),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
