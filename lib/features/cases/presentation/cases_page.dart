import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/Cases/CaseModel.dart';
import 'package:the_helpful_toolbox/data/models/Cases/CaseStateModel.dart';
import 'package:the_helpful_toolbox/features/cases/presentation/dialog/newCaseDialog.dart';
import 'package:the_helpful_toolbox/features/floatingActionButton/actionbutton.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  @override
  State<CasesPage> createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  TextEditingController searchController = TextEditingController();
  List<Case> lCases = List<Case>.empty(growable: true);
  late List<Case> lFilteredCases = List<Case>.empty(growable: true);
  List<CaseState> lCaseState = List<CaseState>.empty(growable: true);
  CaseState _selectedState = CaseState(name: "All");

  @override
  void initState() {
    lFilteredCases = lCases;
    _selectedState = lCaseState.first;
    super.initState();
  }

  getCaseStates() async {
    lCaseState = await caseStateIndex(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cases'),
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
                                                  lFilteredCases = lCases
                                                      .where((e) => e.name
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
                                          DropdownButton(
                                            onChanged: (val) {
                                              setState(() {
                                                _selectedState = val!;
                                              });
                                            },
                                            value: _selectedState,
                                            items: lCaseState
                                                .map((CaseState state) {
                                              return DropdownMenuItem<
                                                  CaseState>(
                                                value: state,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(state.name),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                openNewCaseDialog(context);
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.green[800])),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 8.0),
                                                child: Text("New Case"),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [buildList(context, lCases)],
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

  openNewCaseDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewCaseDialog();
      },
    );
  }

  buildList(BuildContext context, List<Case> lCases) {
    double tableWidth = getScreenWidth(context);
    isSmallScreen(context)
        ? tableWidth = tableWidth - 100
        : tableWidth = tableWidth - 250;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lCases.length,
      itemBuilder: (context, i) {
        return Column(
          children: [Text(lCases[i].name)],
        );
      },
    );
  }
}
