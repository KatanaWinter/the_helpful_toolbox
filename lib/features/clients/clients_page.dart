import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/features/clients/dialog/editClientDialog.dart';
import 'package:the_helpful_toolbox/features/clients/dialog/newClientDialog.dart';
import 'package:the_helpful_toolbox/features/clients/show/client_page.dart';
import 'package:the_helpful_toolbox/features/floatingActionButton/actionbutton.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  TextEditingController searchController = TextEditingController();
  late List<Client> lClients = [];
  late List<Client> lFilteredClients = [];
  late Future dataLoaded;

  @override
  void initState() {
    super.initState();
    // _getData();
    dataLoaded = _getData();
    lFilteredClients = lClients;
  }

  Future<List<Client>> _getData() async {
    lClients = (await getClients(context));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          lFilteredClients = lClients;
        }));
    return lClients;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Clients'),
      ),
      floatingActionButton: const ActionButton(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarNavigation(),
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    children: [
                      Column(
                        children: [
                          Card(
                              elevation: 10,
                              color: ThemeData.dark().cardColor,
                              child: SizedBox(
                                width: isSmallScreen(context)
                                    ? screenWidth - 100
                                    : screenWidth - 250,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: searchController,
                                              decoration: const InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 1.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0),
                                                ),
                                                hintText: 'Search for ...',
                                              ),
                                              onChanged: (val) {
                                                setState(() {
                                                  String searchVal =
                                                      val.toLowerCase();
                                                  lFilteredClients = lClients
                                                      .where((e) =>
                                                          e.firstname!
                                                              .toLowerCase()
                                                              .contains(
                                                                  searchVal) ||
                                                          e.lastname!
                                                              .toLowerCase()
                                                              .contains(
                                                                  searchVal) ||
                                                          e.email!
                                                              .toLowerCase()
                                                              .contains(
                                                                  searchVal) ||
                                                          e.phonenumber!
                                                              .toLowerCase()
                                                              .contains(
                                                                  searchVal) ||
                                                          e.mobilenumber!
                                                              .toLowerCase()
                                                              .contains(
                                                                  searchVal))
                                                      .toList();
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                openNewClientDialog(context);
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.green[800])),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 8.0),
                                                child: Text("New Client"),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          buildAsyncList(context)
                                          // buildList(context, lFilteredClients)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  buildAsyncList(context) {
    return FutureBuilder(
        future: dataLoaded,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildList(context, lFilteredClients);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  buildList(context, List<Client> lFiltered) {
    double tableWidth = getScreenWidth(context);

    NumberFormat formatter = NumberFormat("000000");
    isSmallScreen(context)
        ? tableWidth = tableWidth - 100
        : tableWidth = tableWidth - 250;
    return lClients.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
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
                          color:
                              client.active! >= 1 ? Colors.green : Colors.red),
                      const SizedBox(
                        width: 5,
                      ),
                      isSmallScreen(context)
                          ? const SizedBox()
                          : SizedBox(
                              width: tableWidth * 0.1,
                              child: Text("#${formatter.format(client.id)}")),
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
                            : tableWidth * 0.25,
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
                                children: [
                                  AutoSizeText(
                                    client.billingAddress?.street ?? "",
                                    style: const TextStyle(fontSize: 15),
                                    maxLines: 2,
                                  ),
                                  AutoSizeText(
                                    "${client.billingAddress?.city ?? ""} ${client.billingAddress?.state ?? ""} ${client.billingAddress?.postalcode ?? ""}",
                                    style: const TextStyle(fontSize: 15),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Expanded(
                        child: ButtonBar(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showClient(context, client);
                                },
                                icon: const Icon(Icons.open_in_new)),
                            IconButton(
                                onPressed: () {
                                  openEditClientDialog(context, client);
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  client.deleteClient(context);

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ClientsPage()));
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                      const SizedBox(
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

  showClient(context, Client client) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ClientPage(client)));
  }
}
