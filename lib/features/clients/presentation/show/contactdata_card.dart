import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/addPropertyDialog.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/editPropertyDialog.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class ContactDataCard extends StatelessWidget {
  ClientElement client;
  ContactDataCard(this.client, {super.key});

  @override
  Widget build(BuildContext context) {
    double contentWidth = getContentWidth(context);
    return Card(
        elevation: 10,
        color: ThemeData.dark().cardColor,
        child: SizedBox(
          width: isSmallScreen(context) ? contentWidth : contentWidth * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Contact Data',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Customer:"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Company:"),
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
                            Text("Email:"),
                          ]),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                            "${client.firstname} ${client.lastname}"),
                        SizedBox(
                          height: 10,
                        ),
                        SelectableText(""),
                        SizedBox(
                          height: 10,
                        ),
                        SelectableText("${client.phonenumber}"),
                        SizedBox(
                          height: 10,
                        ),
                        SelectableText("${client.mobilenumber}"),
                        SizedBox(
                          height: 10,
                        ),
                        SelectableText("${client.email}"),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
