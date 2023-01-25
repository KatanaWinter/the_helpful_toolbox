import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/dialog/newClientDialog.dart';

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
        child: const Icon(Icons.add));
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Create New..."),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    openNewClientDialog(context);
                  },
                  icon: const Icon(Icons.people),
                  label: const Text("New Client"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.cases),
                  label: const Text("New Case"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  openNewClientDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NewClientDialog();
      },
    );
  }
}
