import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class ContactDataCard extends StatelessWidget {
  Client client;
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Contact Data',
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
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
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
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                              "${client.firstname} ${client.lastname}"),
                          const SizedBox(
                            height: 10,
                          ),
                          const AutoSizeText(""),
                          const SizedBox(
                            height: 10,
                          ),
                          AutoSizeText(client.phonenumber ?? ""),
                          const SizedBox(
                            height: 10,
                          ),
                          AutoSizeText(client.mobilenumber ?? ""),
                          const SizedBox(
                            height: 10,
                          ),
                          AutoSizeText(
                            client.email ?? "",
                            maxLines: 3,
                          ),
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
}
