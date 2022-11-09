import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/editClientDialog.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/newClientDialog.dart';
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
  List<Property> lProperties = List<Property>.empty(growable: true);
  @override
  void initState() {
    lProperties = getClientProperties(widget.client);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Client _client = widget.client;
    double contentWidth = getContentWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${_client.firstname} ${_client.lastname}"),
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
                  child: Column(
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
                                child: _client.active
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Set Inactive"),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Set Active"),
                                      )),
                            SizedBox(
                              width: 2,
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.edit)),
                          ]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color:
                                    _client.active ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(_client.active ? "Active" : "Inactive"),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: [
                          PropertiesCard(_client, lProperties),
                          CasesCard(_client),
                        ],
                      ),
                      Wrap(
                        children: [
                          ContactDataCard(_client),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getDataItems() {
    List<Client> lClients = getAllClients();
    return lClients;
  }

  buildList(context, List<Client> lFiltered) {
    double tableWidth = getScreenWidth(context);
    isSmallScreen(context)
        ? tableWidth = tableWidth - 100
        : tableWidth = tableWidth - 250;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lFiltered.length,
      itemBuilder: ((context, index) {
        Client client = lFiltered[index];
        return Column(
          children: [
            Row(
              children: [
                Container(
                    width: tableWidth * 0.05,
                    height: 20,
                    color: client.active ? Colors.green : Colors.red),
                const SizedBox(
                  width: 5,
                ),
                isSmallScreen(context)
                    ? SizedBox()
                    : SizedBox(
                        width: tableWidth * 0.1,
                        child: Text(client.id.toString())),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: isSmallScreen(context)
                      ? tableWidth * 0.2
                      : tableWidth * 0.1,
                  child: AutoSizeText(
                    "${client.firstname} ${client.lastname}",
                    style: const TextStyle(fontSize: 15),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: isSmallScreen(context)
                      ? tableWidth * 0.4
                      : tableWidth * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Email: ${client.email}",
                        style: const TextStyle(fontSize: 15),
                        maxLines: 2,
                      ),
                      AutoSizeText(
                        "Mobile: ${client.mobilenumber}",
                        style: const TextStyle(fontSize: 15),
                        maxLines: 2,
                      ),
                      AutoSizeText(
                        "Phone: ${client.phonenumber}",
                        style: const TextStyle(fontSize: 15),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                !isSmallScreen(context)
                    ? SizedBox(
                        width: tableWidth * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            AutoSizeText(
                              "4752 Garret Street",
                              style: const TextStyle(fontSize: 15),
                              maxLines: 2,
                            ),
                            AutoSizeText(
                              "Sunnydale, NH 04985",
                              style: const TextStyle(fontSize: 15),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Spacer(),
                Expanded(
                  child: ButtonBar(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.open_in_new)),
                      IconButton(
                          onPressed: () {
                            openEditClientDialog(context, client);
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            client.delete();
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
            const Divider(),
          ],
        );
      }),
    );
  }

  openNewClientDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewClientDialog();
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

  getClientProperties(Client client) {
    List<Property> lProperties = [
      Property(
          name: "Main Property",
          street: "Meta-Grube-Weg 29",
          city: "Cuxhaven",
          postalcode: "27474",
          state: "NI"),
      Property(
          name: "Second Property",
          street: "Meta-Grube-Weg 29",
          city: "Cuxhaven",
          postalcode: "27474",
          state: "NI"),
    ];
    return lProperties;
  }
}
