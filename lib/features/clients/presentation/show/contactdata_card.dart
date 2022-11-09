import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/clients/data/client.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/addPropertyDialog.dart';
import 'package:the_helpful_toolbox/features/clients/presentation/dialog/editPropertyDialog.dart';
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
          width: isSmallScreen(context) ? contentWidth : contentWidth * 0.45,
          child: Column(
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
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
