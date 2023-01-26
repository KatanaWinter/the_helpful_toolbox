import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/OfferListModel.dart';
import 'package:the_helpful_toolbox/features/clients/clients_page.dart';
import 'package:the_helpful_toolbox/features/offerlist/offerlists_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class EditOfferlistDialog extends StatefulWidget {
  int cId;
  Offerlist offerlist;
  EditOfferlistDialog({super.key, required this.cId, required this.offerlist});

  @override
  State<EditOfferlistDialog> createState() => _EditOfferlistDialogState();
}

class _EditOfferlistDialogState extends State<EditOfferlistDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Offerlist'),
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
                                initialValue: widget.offerlist.name,
                                onChanged: (val) => setState(() {
                                  widget.offerlist.name = val;
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
                                initialValue: widget.offerlist.description,
                                onChanged: (val) => setState(() {
                                  widget.offerlist.description = val;
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
              saveOfferlist(context, widget.offerlist);
            } else {}
            // Hier passiert etwas anderes
          },
        ),
      ],
    );
  }

  saveOfferlist(context, Offerlist offerlist) async {
    debugPrint("edit offerlist to Database");
    await offerlist.offerlistUpdate(context);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const OfferlistPage()));
  }
}
