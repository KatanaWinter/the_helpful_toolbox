import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/newClientDialog.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class ClientsPage extends StatelessWidget {
  ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List<Client> lClients = getAllClients();
    double tableWidth = 0.00;

    double screenWidth = getScreenWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Clients'),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SidebarNavigation(screenWidth),
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
                                          buildList(context, lClients)
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

  getDataItems() {
    List<Client> lClients = getAllClients();
    return lClients;
  }

  buildList(context, List<Client> lClients) {
    double tableWidth = getScreenWidth(context);
    isSmallScreen(context)
        ? tableWidth = tableWidth - 100
        : tableWidth = tableWidth - 250;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lClients.length,
      itemBuilder: ((context, index) {
        Client client = lClients[index];
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
                SizedBox(
                    width: tableWidth * 0.1, child: Text(client.id.toString())),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: tableWidth * 0.1,
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
                      ? tableWidth * 0.5
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
                          children: [
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
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
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

  // set up the button

}
