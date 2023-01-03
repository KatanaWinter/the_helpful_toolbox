import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/MediaModel.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class DisplayMediaList extends StatefulWidget {
  List<Media> lMedia;
  DisplayMediaList({required this.lMedia, super.key});

  @override
  State<DisplayMediaList> createState() => _DisplayMediaListState();
}

class _DisplayMediaListState extends State<DisplayMediaList> {
  TextEditingController searchController = TextEditingController();
  List<Media> lMedia = [];
  List<Media> lFilteredMedia = [];
  String _searchResult = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lMedia = widget.lMedia;
    lFilteredMedia = lMedia;
  }

  @override
  Widget build(BuildContext context) {
    double contentWidth = getContentWidth(context);

    double width = double.maxFinite;
    double screenWidth = getScreenWidth(context);

    return Card(
        elevation: 10,
        color: ThemeData.dark().cardColor,
        child: SizedBox(
          width: isSmallScreen(context) ? width : width - 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Media',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: isSmallScreen(context) ? 100 : 200,
                                child: TextField(
                                  controller: searchController,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    hintText: 'Search for ...',
                                  ),
                                  onChanged: (val) {
                                    _searchResult = val;
                                    setState(() {
                                      String _searchVal = val.toLowerCase();
                                      lFilteredMedia = lMedia
                                          .where((e) => e.fileName!
                                              .toLowerCase()
                                              .contains(_searchVal))
                                          .toList();
                                    });
                                  },
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                  onPressed: () {
                                    // openNewEmployeeDialog(context, snapshot.data!);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green[800])),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 8.0),
                                    child: Text("New Media"),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [buildList(context, lFilteredMedia)],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  buildList(BuildContext context, List<Media> lFilteredMedia) {
    return lFilteredMedia.length <= 0
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: lFilteredMedia.length,
              itemBuilder: ((context, index) {
                Media _media = lFilteredMedia[index];
                return Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 200,
                            height: 50,
                            child: AutoSizeText(
                                textAlign: TextAlign.start,
                                "${_media.fileName} "),
                          ),
                          Expanded(
                            child: ButtonBar(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      // showEmployee(context, employee);
                                    },
                                    icon: const Icon(Icons.download)),
                                IconButton(
                                    onPressed: () {
                                      // employee.employeeDelete(context);
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             CompanyPage()));
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
}
