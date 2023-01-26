import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/OfferListModel.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/features/offerlist/dialog/createOfferlistDialog.dart';
import 'package:the_helpful_toolbox/features/offerlist/offerlist_table.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class OfferlistPage extends StatefulWidget {
  const OfferlistPage({super.key});

  @override
  State<OfferlistPage> createState() => _OfferlistPageState();
}

class _OfferlistPageState extends State<OfferlistPage> {
  Future<List<Offerlist>>? _fOfferList;
  @override
  void initState() {
    super.initState();
    _fOfferList = getOfferlists(1);
  }

  Future<List<Offerlist>> getOfferlists(int cId) async {
    List<Offerlist> lOfferlist = await offerlistIndex(context);
    return lOfferlist;
  }

  @override
  Widget build(BuildContext context) {
    double contentWidth = getContentWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Offerlists'),
      ),
      body: FutureBuilder<List<Offerlist>>(
        future: _fOfferList,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<Offerlist> lOfferLists = snapshot.data!;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SidebarNavigation(),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: isSmallScreen(context)
                            ? contentWidth - 20
                            : contentWidth,
                        child: Wrap(
                          children: [
                            Card(
                                elevation: 10,
                                color: ThemeData.dark().cardColor,
                                child: SizedBox(
                                  width: contentWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Offerlists',
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
                                          const Spacer(),
                                          ElevatedButton(
                                              onPressed: () {
                                                openNewOfferlist(context, 1);
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.green[800])),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 8.0),
                                                child: Text("New Offerlist"),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          lOfferLists == null
                                              ? const Text("no offerlists yet")
                                              : OfferListTable(
                                                  ciD: 1, lOfferLists),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  openNewOfferlist(context, int company) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreatOfferlistDialog(
          cId: company,
        );
      },
    );
  }
}
