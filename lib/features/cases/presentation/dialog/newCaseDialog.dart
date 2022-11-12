import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class NewCaseDialog extends StatefulWidget {
  NewCaseDialog({super.key});

  @override
  State<NewCaseDialog> createState() => _NewCaseDialogState();
}

class _NewCaseDialogState extends State<NewCaseDialog> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('New Case')),
      content: SingleChildScrollView(
        child: SizedBox(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green[800])),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Request"),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange[800])),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Quote"),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.brown[800])),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Job"),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.purple[800])),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Invoice"),
                )),
          ],
        )),
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
      ],
    );
  }

  saveClientWithProperty(context) {
    debugPrint("edit client to Database");
    Navigator.of(context).pop();
  }
}
