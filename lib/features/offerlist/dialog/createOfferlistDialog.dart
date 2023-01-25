import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/OfferListModel.dart';
import 'package:the_helpful_toolbox/features/clients/clients_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class CreatOfferlistDialog extends StatefulWidget {
  int cId;
  CreatOfferlistDialog({super.key, required this.cId});

  @override
  State<CreatOfferlistDialog> createState() => _CreatOfferlistDialogState();
}

class _CreatOfferlistDialogState extends State<CreatOfferlistDialog> {
  final _formKey = GlobalKey<FormState>();
  final Offerlist _offerlist = Offerlist(active: 1, description: "", name: "");

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Offerlist'),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name'),
                                onChanged: (val) => setState(() {
                                  _offerlist.name = val;
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
                                    labelText: 'Description'),
                                onChanged: (val) => setState(() {
                                  _offerlist.description = val;
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
              saveOfferlist(context, _offerlist);
            } else {}
            // Hier passiert etwas anderes
          },
        ),
      ],
    );
  }

  saveOfferlist(context, Offerlist offerlist) async {
    debugPrint("save offerlist to Database");
    await offerlist.offerlistStore(context);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ClientsPage()));
  }
}
