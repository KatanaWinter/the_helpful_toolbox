import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/editClientDialog.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/newClientDialog.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/show/billingAddress_card.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/show/cases_card.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/show/contactdata_card.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/show/properties_card.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class ClientPage extends StatefulWidget {
  Client client;
  ClientPage(this.client, {Key? key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  Future<Client>? dataLoaded;
  Client _client = Client();
  @override
  void initState() {
    super.initState();
    _client = widget.client;

    dataLoaded = _getData();
  }

  Future<Client> _getData() async {
    Client client = await _client.showClient();
    return client;
  }

  @override
  Widget build(BuildContext context) {
    Client client = _client;
    double contentWidth = getContentWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${client.firstname} ${client.lastname}"),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarNavigation(contentWidth),
            SingleChildScrollView(
              child: SizedBox(
                width: contentWidth,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: buildAsyncList(context, client)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildAsyncList(context, client) {
    return FutureBuilder(
        future: dataLoaded,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              Client client = snapshot.data!;
              return Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Back to Clients"),
                          )),
                      const Spacer(),
                      ButtonBar(children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.brown[700])),
                            onPressed: () {
                              debugPrint("ToDo: implement set active");
                            },
                            child: snapshot.data!.active >= 1
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Set Inactive"),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Set Active"),
                                  )),
                        const SizedBox(
                          width: 2,
                        ),
                        IconButton(
                            onPressed: () {
                              openEditClientDialog(context, snapshot.data!);
                            },
                            icon: const Icon(Icons.edit)),
                      ]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: snapshot.data!.active >= 1
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data!.active >= 1
                              ? "Active"
                              : "Inactive"),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: [
                      Column(
                        children: [
                          ContactDataCard(snapshot.data!),
                          BillingAddressCard(snapshot.data!)
                        ],
                      ),
                      PropertiesCard(snapshot.data!),
                    ],
                  ),
                  Wrap(
                    children: [
                      CasesCard(snapshot.data!),
                    ],
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        });
  }

  openNewClientDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NewClientDialog();
      },
    );
  }

  openEditClientDialog(context, Client client) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditClientDialog(client);
      },
    );
  }
}
