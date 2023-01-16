import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/CompanyModel.dart';
import 'package:the_helpful_toolbox/data/models/OfferListModel.dart';
import 'package:the_helpful_toolbox/features/company/dialog/EmployeeCreateDialog.dart';
import 'package:the_helpful_toolbox/features/company/dialog/editCompanyaddressDialog.dart';
import 'package:the_helpful_toolbox/features/company/dialog/editCompanydataDialog.dart';
import 'package:the_helpful_toolbox/features/company/employees_table.dart';
import 'package:the_helpful_toolbox/features/media/displayMediaList.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/features/offerlist/dialog/createOfferlistDialog.dart';
import 'package:the_helpful_toolbox/features/offerlist/offerlist_table.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class OfferlistPage extends StatefulWidget {
  OfferlistPage({super.key});

  @override
  State<OfferlistPage> createState() => _OfferlistPageState();
}

class _OfferlistPageState extends State<OfferlistPage> {
  Future<List<Offerlist>>? _fOfferList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fOfferList = getOfferlists(1);
  }

  Future<List<Offerlist>> getOfferlists(int cId) async {
    List<Offerlist> lOfferlist = await offerlistIndex(context);
    print("test");
    return lOfferlist;
  }

  @override
  Widget build(BuildContext context) {
    double contentWidth = getContentWidth(context);
    double screenWidth = getScreenWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Company'),
      ),
      body: FutureBuilder<List<Offerlist>>(
        future: _fOfferList,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<Offerlist> _lOfferLists = snapshot.data!;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SidebarNavigation(),
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
                                          Spacer(),
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
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          _lOfferLists == null
                                              ? Text("no offerlists yet")
                                              : OfferListTable(
                                                  ciD: 1, _lOfferLists),
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
          return Center(child: CircularProgressIndicator());
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
