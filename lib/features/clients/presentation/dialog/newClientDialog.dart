import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/clients_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class NewClientDialog extends StatefulWidget {
  const NewClientDialog({super.key});

  @override
  State<NewClientDialog> createState() => _NewClientDialogState();
}

class _NewClientDialogState extends State<NewClientDialog> {
  final _formKey = GlobalKey<FormState>();
  Client _client = Client(
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

  Property _billingAddress = Property(
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              // Card(
              //   elevation: 10,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: SizedBox(
              //         width: isSmallScreen(context)
              //             ? getScreenWidth(context)
              //             : getScreenWidth(context) * 0.4,
              //         height: getScreenHeight(context),
              //         child: FocusScope(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               const Text("Property:"),
              //               const SizedBox(
              //                 height: 10,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: TextFormField(
              //                   decoration: const InputDecoration(
              //                       border: OutlineInputBorder(),
              //                       labelText: 'Name'),
              //                   onChanged: (val) => setState(() {
              //                     _billingAddress.name = val;
              //                   }),
              //                   validator: (value) {
              //                     if (value!.isEmpty &&
              //                         _billingAddress.name.isNotEmpty) {
              //                       return 'Please enter a value';
              //                     }
              //                     return null;
              //                   },
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: TextFormField(
              //                   decoration: const InputDecoration(
              //                       border: OutlineInputBorder(),
              //                       labelText: 'Street'),
              //                   onChanged: (val) => setState(() {
              //                     _billingAddress.street = val;
              //                   }),
              //                   validator: (value) {
              //                     if (value!.isEmpty &&
              //                         _billingAddress.name.isNotEmpty) {
              //                       return 'Please enter a value';
              //                     }
              //                     return null;
              //                   },
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: TextFormField(
              //                   decoration: const InputDecoration(
              //                       border: OutlineInputBorder(),
              //                       labelText: 'Street 2'),
              //                   onChanged: (val) => setState(() {
              //                     _billingAddress.street2 = val;
              //                   }),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: TextFormField(
              //                   decoration: const InputDecoration(
              //                       border: OutlineInputBorder(),
              //                       labelText: 'City'),
              //                   onChanged: (val) => setState(() {
              //                     _billingAddress.city = val;
              //                   }),
              //                   validator: (value) {
              //                     if (value!.isEmpty &&
              //                         _billingAddress.name.isNotEmpty) {
              //                       return 'Please enter a value';
              //                     }
              //                     return null;
              //                   },
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: TextFormField(
              //                   decoration: const InputDecoration(
              //                       border: OutlineInputBorder(),
              //                       labelText: 'State'),
              //                   onChanged: (val) => setState(() {
              //                     _billingAddress.state = val;
              //                   }),
              //                   validator: (value) {
              //                     if (value!.isEmpty &&
              //                         _billingAddress.name.isNotEmpty) {
              //                       return 'Please enter a value';
              //                     }
              //                     return null;
              //                   },
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: TextFormField(
              //                   decoration: const InputDecoration(
              //                       border: OutlineInputBorder(),
              //                       labelText: 'Postal Code'),
              //                   onChanged: (val) => setState(() {
              //                     _billingAddress.postalcode = val;
              //                   }),
              //                   validator: (value) {
              //                     if (value!.isEmpty &&
              //                         _billingAddress.name.isNotEmpty) {
              //                       return 'Please enter a value';
              //                     }
              //                     return null;
              //                   },
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )),
              //   ),
              // ),
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
            } else {
              print('Error');
            }
            // Hier passiert etwas anderes
          },
        ),
      ],
    );
  }

  saveClientWithProperty(
      context, Client _client, Property billingAddress) async {
    debugPrint("save client to Database");
    if (_billingAddress.name.isNotEmpty) {
      _client.billingAddress = _billingAddress;
      await _client.saveClient(_client);
    } else {
      await _client.saveClient(_client);
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ClientsPage()));
  }
}
