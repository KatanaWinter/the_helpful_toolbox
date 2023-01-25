import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

import '../../../data/models/Cases/CaseModel.dart';

class CasesCard extends StatefulWidget {
  Client client;
  CasesCard(this.client, {super.key});

  @override
  State<CasesCard> createState() => _CasesCardState();
}

class _CasesCardState extends State<CasesCard> {
  TextEditingController searchController = TextEditingController();

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
    lCases = List<Case>.empty(growable: true);
    lFilteredCases = lCases;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double contentWidth = getContentWidth(context);
    double tableWidth =
        isSmallScreen(context) ? contentWidth - 16 : (contentWidth * 0.9) - 16;
    return Card(
        elevation: 10,
        color: ThemeData.dark().cardColor,
        child: SizedBox(
          width: isSmallScreen(context) ? contentWidth : contentWidth * 0.9,
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
                          setState(() {
                            String searchVal = val.toLowerCase();
                            lFilteredCases = lCases
                                .where((e) =>
                                    e.name!.toLowerCase().contains(searchVal) ||
                                    e.state!.name!
                                        .toLowerCase()
                                        .contains(searchVal) ||
                                    e.propertie!.street!
                                        .toLowerCase()
                                        .contains(searchVal) ||
                                    e.propertie!.city!
                                        .toLowerCase()
                                        .contains(searchVal) ||
                                    e.propertie!.postalcode!
                                        .toLowerCase()
                                        .contains(searchVal))
                                .toList();
                          });
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
                            lFilteredCases = lCases;
                            allActions = true;
                            activeJobs = false;
                            requests = false;
                            quotes = false;
                            jobs = false;
                            invoices = false;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: allActions
                                ? MaterialStateProperty.all(
                                    const Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue)),
                        child: const AutoSizeText("All Cases")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            lFilteredCases = lCases
                                .where((e) =>
                                    e.state?.name?.toLowerCase() == "jobs" &&
                                    e.status?.name?.toLowerCase() == "new")
                                .toList();

                            allActions = false;
                            activeJobs = true;
                            requests = false;
                            quotes = false;
                            jobs = false;
                            invoices = false;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: activeJobs
                                ? MaterialStateProperty.all(
                                    const Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue)),
                        child: const Text("Active Jobs")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            lFilteredCases = lCases
                                .where((e) =>
                                    e.state!.name!.toLowerCase() == "request")
                                .toList();
                            allActions = false;
                            activeJobs = false;
                            requests = true;
                            quotes = false;
                            jobs = false;
                            invoices = false;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: requests
                                ? MaterialStateProperty.all(
                                    const Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue)),
                        child: const Text("Requests")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            lFilteredCases = lCases
                                .where((e) => e.state!.name!
                                    .toLowerCase()
                                    .contains("quote"))
                                .toList();
                            allActions = false;
                            activeJobs = false;
                            requests = false;
                            quotes = true;
                            jobs = false;
                            invoices = false;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: quotes
                                ? MaterialStateProperty.all(
                                    const Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue)),
                        child: const Text("Quotes")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            lFilteredCases = lCases
                                .where((e) =>
                                    e.state!.name!.toLowerCase() == "job")
                                .toList();
                            allActions = false;
                            activeJobs = false;
                            requests = false;
                            quotes = false;
                            jobs = true;
                            invoices = false;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: jobs
                                ? MaterialStateProperty.all(
                                    const Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue)),
                        child: const Text("Jobs")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            lFilteredCases = lCases
                                .where((e) =>
                                    e.state!.name!.toLowerCase() == "invoice")
                                .toList();
                            allActions = false;
                            activeJobs = false;
                            requests = false;
                            quotes = false;
                            jobs = false;
                            invoices = true;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: invoices
                                ? MaterialStateProperty.all(
                                    const Color.fromARGB(255, 50, 73, 0))
                                : MaterialStateProperty.all(Colors.blue)),
                        child: const Text("Invoices")),
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
                              child: const AutoSizeText("Type"),
                            ),
                            SizedBox(
                              width: tableWidth * 0.3,
                              child: const AutoSizeText("Job Name"),
                            ),
                            SizedBox(
                              width: tableWidth * 0.3,
                              child: const AutoSizeText("Address"),
                            ),
                            // SizedBox(
                            //   width: tableWidth * 0.1,
                            //   child: AutoSizeText("Price"),
                            // ),
                          ],
                        ),
                        const SizedBox(
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
                        child: AutoSizeText(sCase.state?.name ?? "")),
                    SizedBox(
                        width: listWidth * 0.3,
                        child: AutoSizeText(sCase.name ?? "")),
                    SizedBox(
                      width: listWidth * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            sCase.propertie!.street!,
                            style: const TextStyle(fontSize: 15),
                            maxLines: 2,
                          ),
                          AutoSizeText(
                            "${sCase.propertie!.city} ${sCase.propertie!.state} ${sCase.propertie!.postalcode}",
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
