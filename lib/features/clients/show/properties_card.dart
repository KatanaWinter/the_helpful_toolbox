import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/data/models/property.dart';
import 'package:the_helpful_toolbox/features/clients/dialog/addPropertyDialog.dart';
import 'package:the_helpful_toolbox/features/clients/dialog/editPropertyDialog.dart';
import 'package:the_helpful_toolbox/features/clients/show/client_page.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class PropertiesCard extends StatelessWidget {
  Client client;
  PropertiesCard(this.client, {super.key});

  @override
  Widget build(BuildContext context) {
    double contentWidth = getContentWidth(context);
    return Card(
        elevation: 10,
        color: ThemeData.dark().cardColor,
        child: SizedBox(
          width: isSmallScreen(context) ? contentWidth : contentWidth * 0.6,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    'Properties',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      openAddPropertyDialog(context, client);
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    // shrinkWrap: true,
                    itemCount: client.properties!.length,
                    itemBuilder: ((context, index) {
                      Property property = client.properties![index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: contentWidth * 0.1,
                                  child: AutoSizeText(property.name!)),
                              SizedBox(
                                width: contentWidth * 0.2,
                                child: AutoSizeText(
                                    "${property.street} ${property.city}, ${property.state} ${property.postalcode}",
                                    maxLines: 3),
                              ),
                              ButtonBar(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        openEditPropertyDialog(
                                            context, property);
                                      },
                                      icon: const Icon(Icons.edit)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        property.propertyDelete(context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ClientPage(client)));
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: Colors.redAccent),
                                ],
                              ),
                            ],
                          ));
                    })),
              )
            ],
          ),
        ));
  }

  openAddPropertyDialog(context, Client client) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddPropertyDialog(client);
      },
    );
  }

  openEditPropertyDialog(context, Property property) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditPropertyDialog(property, client);
      },
    );
  }
}
