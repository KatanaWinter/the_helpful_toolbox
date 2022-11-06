import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class NewClientDialog extends StatefulWidget {
  const NewClientDialog({super.key});

  @override
  State<NewClientDialog> createState() => _NewClientDialogState();
}

class _NewClientDialogState extends State<NewClientDialog> {
  final _formKey = GlobalKey<FormState>();
  Client _client = new Client(firstname: "", lastname: "");
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Client'),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Client:"),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'First name'),
                              onChanged: (val) => setState(() {
                                _client.firstname = val;
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Last name'),
                              onChanged: (val) => setState(() {
                                _client.lastname = val;
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Company name'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Mobile number'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email'),
                            ),
                          ),
                        ],
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Property:"),
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
            // Hier passiert etwas anderes
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  saveClientWithProperty() {}
}
