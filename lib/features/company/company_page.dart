import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/CompanyModel.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';
import 'package:the_helpful_toolbox/features/company/dialog/editCompanyaddressDialog.dart';
import 'package:the_helpful_toolbox/features/company/dialog/editCompanydataDialog.dart';
import 'package:the_helpful_toolbox/features/company/employees_table.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  Future<Company>? _fCompany;
  Company _company = Company(id: 1);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fCompany = getCompany();
  }

  Future<Company> getCompany() async {
    Company company = await _company.companyShow(context);
    print("test");
    return company;
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
      body: FutureBuilder<Company>(
        future: _fCompany,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                SidebarNavigation(screenWidth),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(children: [
                      Card(
                          elevation: 10,
                          color: ThemeData.dark().cardColor,
                          child: SizedBox(
                            width: isSmallScreen(context)
                                ? contentWidth
                                : contentWidth * 0.3,
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
                                        'Company Logo',
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
                                        width: 100,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const []),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Card(
                          elevation: 10,
                          color: ThemeData.dark().cardColor,
                          child: SizedBox(
                            width: isSmallScreen(context)
                                ? contentWidth
                                : contentWidth * 0.3,
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
                                    children: [
                                      Text(
                                        'Company Data',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            openEditDataDialog(
                                                context, snapshot.data!);
                                          },
                                          icon: Icon(Icons.edit))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text("Name:"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("Phone:"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("Mobile:"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ]),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.name ?? ""),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SelectableText(
                                              snapshot.data!.phone ?? ""),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SelectableText(
                                              snapshot.data!.mobile ?? ""),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Card(
                          elevation: 10,
                          color: ThemeData.dark().cardColor,
                          child: SizedBox(
                            width: isSmallScreen(context)
                                ? contentWidth
                                : contentWidth * 0.3,
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
                                    children: [
                                      Text(
                                        'Company Address',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            openEditPropertyDialog(
                                                context, snapshot.data!);
                                          },
                                          icon: Icon(Icons.edit))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text("Street:"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("Street 2:"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("City:"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("State:"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("Zip:"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ]),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectableText(snapshot
                                                  .data!.propertie?.street ??
                                              ""),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SelectableText(snapshot
                                                  .data!.propertie?.street2 ??
                                              ""),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SelectableText(
                                              snapshot.data!.propertie?.city ??
                                                  ""),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SelectableText(
                                              snapshot.data!.propertie?.state ??
                                                  ""),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SelectableText(snapshot.data!
                                                  .propertie?.postalcode ??
                                              ""),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ]),
                    Wrap(
                      children: [
                        Card(
                            elevation: 10,
                            color: ThemeData.dark().cardColor,
                            child: SizedBox(
                              width: isSmallScreen(context)
                                  ? contentWidth
                                  : contentWidth - 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Employees',
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
                                        EmployeesTable(
                                            snapshot.data!.employees!),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    )
                  ],
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

  openEditDataDialog(context, Company comp) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditCompanyDataDialog(company: comp);
      },
    );
  }

  openEditPropertyDialog(context, Company comp) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditCompanyAddressDialog(company: comp);
      },
    );
  }
}
