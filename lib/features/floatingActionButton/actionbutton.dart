import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({super.key});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        backgroundColor: Colors.green[600],
        child: Icon(Icons.add));
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Create New..."),
          content: Container(
            height: 200,
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.people),
                  label: Text("New Client"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.cases),
                  label: Text("New Case"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
