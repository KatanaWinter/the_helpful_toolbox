import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class CasesCard extends StatefulWidget {
  Client client;
  CasesCard(this.client, {super.key});

  @override
  State<CasesCard> createState() => _CasesCardState();
}

class _CasesCardState extends State<CasesCard> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    String _searchResult;
    double contentWidth = getContentWidth(context);
    return Card(
        elevation: 10,
        color: ThemeData.dark().cardColor,
        child: SizedBox(
          width: isSmallScreen(context) ? contentWidth : contentWidth * 0.45,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cases Overview',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintText: 'Search for ...',
                      ),
                      onChanged: (val) {
                        _searchResult = val;
                        setState(() {
                          String _searchVal = val.toLowerCase();
                          lFilteredClients = lClients
                              .where((e) =>
                                  e.firstname
                                      .toLowerCase()
                                      .contains(_searchVal) ||
                                  e.lastname
                                      .toLowerCase()
                                      .contains(_searchVal) ||
                                  e.email.toLowerCase().contains(_searchVal) ||
                                  e.phonenumber
                                      .toLowerCase()
                                      .contains(_searchVal) ||
                                  e.mobilenumber
                                      .toLowerCase()
                                      .contains(_searchVal))
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
                        // openNewClientDialog(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[800])),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 8.0),
                        child: Text("New Client"),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
