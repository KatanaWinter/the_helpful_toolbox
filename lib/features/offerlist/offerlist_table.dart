import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_helpful_toolbox/data/models/CompanyModel.dart';
import 'package:the_helpful_toolbox/data/models/OfferListModel.dart';
import 'package:the_helpful_toolbox/features/offerlist/offerlists_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class OfferListTable extends StatefulWidget {
  late List<Offerlist> lOfferlists;
  int ciD;
  OfferListTable(this.lOfferlists, {super.key, required this.ciD});

  @override
  State<OfferListTable> createState() => _OfferListTableState();
}

class _OfferListTableState extends State<OfferListTable> {
  TextEditingController searchController = TextEditingController();
  List<Offerlist> lOLists = [];
  List<Offerlist> lFilteredOLists = [];
  String _searchResult = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lOLists = widget.lOfferlists;
    lFilteredOLists = lOLists;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    double contentWidth = getContentWidth(context);

    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: isSmallScreen(context)
                      ? contentWidth - 60
                      : contentWidth / 2 - 50,
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Search for ...',
                    ),
                    onChanged: (val) {
                      _searchResult = val;
                      setState(() {
                        String _searchVal = val.toLowerCase();
                        lFilteredOLists = lOLists
                            .where((e) =>
                                e.name!.toLowerCase().contains(_searchVal))
                            .toList();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [buildList(context, lFilteredOLists)],
            ),
          )
        ],
      ),
    );
  }

  buildList(BuildContext context, List<Offerlist> lFilterdOList) {
    double tableWidth = getScreenWidth(context);
    NumberFormat formatter = new NumberFormat("000000");
    isSmallScreen(context)
        ? tableWidth = tableWidth - 100
        : tableWidth = tableWidth / 2 - 250;

    return lOLists.length <= 0
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: lFilterdOList.length,
              itemBuilder: ((context, index) {
                Offerlist oList = lFilterdOList[index];
                return Container(
                  width: tableWidth,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: tableWidth * 0.1,
                            height: 50,
                            child: AutoSizeText(
                                textAlign: TextAlign.start,
                                "#${formatter.format(oList.id!)}"),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: tableWidth * 0.15,
                            height: 50,
                            child: AutoSizeText(oList.name ?? ""),
                          ),
                          Expanded(
                            child: ButtonBar(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showOfferlist(context, oList);
                                    },
                                    icon: const Icon(Icons.open_in_new)),
                                IconButton(
                                    onPressed: () {
                                      openEditOfferlistDialog(
                                          context, widget.ciD, oList);
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      oList.offerlistDelete(context);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OfferlistPage()));
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                      )
                    ],
                  ),
                );
              }),
            ),
          );
  }

  openEditOfferlistDialog(context, int cId, Offerlist _oList) {
    // return showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return OfferListEditDialog(
    //         employee: _oList,
    //         backPage: OfferlistPage(
    //           company: company,
    //         ));
    //   },
    // );
  }

  showOfferlist(context, Offerlist oList) {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => EmployeePage(employee)));
  }
}
