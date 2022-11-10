import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/cases/data/case.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class CasesCard extends StatefulWidget {
  Client client;
  CasesCard(this.client, {super.key});

  @override
  State<CasesCard> createState() => _CasesCardState();
}

class _CasesCardState extends State<CasesCard> {
  List<Case> lCases = List<Case>.empty(growable: true);
  List<Case> lFilteredCases = List<Case>.empty(growable: true);
  bool allActions = true,
      activeJobs = false,
      requests = false,
      quotes = false,
      jobs = false,
      invoices = false;
  @override
  void initState() {
    lCases = getCasesOfClient(widget.client);
    lFilteredCases = lCases;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    String _searchResult;
    double contentWidth = getContentWidth(context);
    double tableWidth =
        isSmallScreen(context) ? contentWidth - 16 : (contentWidth * 0.45) - 16;
    return Card(
        elevation: 10,
        color: ThemeData.dark().cardColor,
        child: SizedBox(
          width: isSmallScreen(context) ? contentWidth : contentWidth * 0.45,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Cases Overview',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
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
                          // setState(() {
                          //   String _searchVal = val.toLowerCase();
                          //   lFilteredCases = lCases
                          //       .where((e) =>
                          //           e.name.toLowerCase().contains(_searchVal))
                          //       .toList();
                          // });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            allActions = true;
                            activeJobs = false;
                            requests = false;
                            quotes = false;
                            jobs = false;
                            invoices = false;
                          });
                        },
                        child: AutoSizeText("All Cases"),
                        style: ButtonStyle(
                            backgroundColor: allActions
                                ? MaterialStateProperty.all(
                                    Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue))),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            allActions = false;
                            activeJobs = true;
                            requests = false;
                            quotes = false;
                            jobs = false;
                            invoices = false;
                          });
                        },
                        child: Text("Active Jobs"),
                        style: ButtonStyle(
                            backgroundColor: activeJobs
                                ? MaterialStateProperty.all(
                                    Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue))),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            allActions = false;
                            activeJobs = false;
                            requests = true;
                            quotes = false;
                            jobs = false;
                            invoices = false;
                          });
                        },
                        child: Text("Requests"),
                        style: ButtonStyle(
                            backgroundColor: requests
                                ? MaterialStateProperty.all(
                                    Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue))),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            allActions = false;
                            activeJobs = false;
                            requests = false;
                            quotes = true;
                            jobs = false;
                            invoices = false;
                          });
                        },
                        child: Text("Quotes"),
                        style: ButtonStyle(
                            backgroundColor: quotes
                                ? MaterialStateProperty.all(
                                    Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue))),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            allActions = false;
                            activeJobs = false;
                            requests = false;
                            quotes = false;
                            jobs = true;
                            invoices = false;
                          });
                        },
                        child: Text("Jobs"),
                        style: ButtonStyle(
                            backgroundColor: jobs
                                ? MaterialStateProperty.all(
                                    Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue))),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            allActions = false;
                            activeJobs = false;
                            requests = false;
                            quotes = false;
                            jobs = false;
                            invoices = true;
                          });
                        },
                        child: Text("Invoices"),
                        style: ButtonStyle(
                            backgroundColor: invoices
                                ? MaterialStateProperty.all(
                                    Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue))),
                  ],
                ),
                SizedBox(
                  width: tableWidth,
                  child: Card(
                    elevation: 20,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: tableWidth * 0.2,
                              child: Text("Type"),
                            ),
                            SizedBox(
                              width: tableWidth * 0.3,
                              child: Text("Job Name"),
                            ),
                            SizedBox(
                              width: tableWidth * 0.3,
                              child: Text("Address"),
                            ),
                            SizedBox(
                              width: tableWidth * 0.1,
                              child: Text("Price"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildList(tableWidth, lFilteredCases)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  buildList(listWidth, List<Case> lFiltered) {
    double tableWidth = getScreenWidth(context);
    return SizedBox(
      height: 200,
      width: listWidth,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        itemCount: lFiltered.length,
        itemBuilder: ((context, index) {
          Case sCase = lFiltered[index];
          return Column(
            children: [
              SingleChildScrollView(
                child: Row(
                  children: [
                    SizedBox(
                        width: listWidth * 0.2,
                        child: AutoSizeText(sCase.state.name)),
                    SizedBox(
                        width: listWidth * 0.3,
                        child: AutoSizeText(sCase.name)),
                    SizedBox(
                      width: listWidth * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            sCase.property.street,
                            style: const TextStyle(fontSize: 15),
                            maxLines: 2,
                          ),
                          AutoSizeText(
                            "${sCase.property.city} ${sCase.property.state} ${sCase.property.postalcode}",
                            style: const TextStyle(fontSize: 15),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          );
        }),
      ),
    );
  }
}
