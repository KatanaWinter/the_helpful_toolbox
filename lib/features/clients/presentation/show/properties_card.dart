import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/addPropertyDialog.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/editPropertyDialog.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class PropertiesCard extends StatelessWidget {
  ClientElement client;
  List<Property> lProperties;
  PropertiesCard(this.client, this.lProperties, {super.key});

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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    'Properties',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      openAddPropertyDialog(context, client);
                    },
                    child: Icon(Icons.add),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    // shrinkWrap: true,
                    itemCount: lProperties.length,
                    itemBuilder: ((context, index) {
                      Property property = lProperties[index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: contentWidth * 0.1,
                                  child: AutoSizeText(property.name)),
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
                                      icon: Icon(Icons.edit))
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

  openAddPropertyDialog(context, ClientElement client) {
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
        return EditPropertyDialog(property);
      },
    );
  }
}
