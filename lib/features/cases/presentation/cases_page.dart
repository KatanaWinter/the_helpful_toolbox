import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/cases/data/case.dart';
import 'package:the_helpful_toolbox/features/cases/data/case_state.dart';
import 'package:the_helpful_toolbox/features/cases/data/case_status.dart';
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
  List<Case> lCases = getAllCases();
  late List<Case> lFilteredCases = List<Case>.empty(growable: true);
  String _searchResult = '';
  List<CaseState> lCaseState = getAllStateFilter();
  CaseState _selectedState = CaseState(name: "All");

  @override
  void initState() {
    lFilteredCases = lCases;
    _selectedState = lCaseState.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double tableWidth = 0.00;

    double screenWidth = getScreenWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cases'),
      ),
      floatingActionButton: ActionButton(),
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
                                              onChanged: (val) {
                                                _searchResult = val;
                                                setState(() {
                                                  String _searchVal =
                                                      val.toLowerCase();
                                                  lFilteredCases = lCases
                                                      .where((e) => e.name
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
                                                // openNewClientDialog(context);
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
                                        children: [
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

  openNewCaseDialog() {}
}
