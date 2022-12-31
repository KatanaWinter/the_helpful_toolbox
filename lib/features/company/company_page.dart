import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Row(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          : contentWidth * 0.4,
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
                                  'Company Data',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [],
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
