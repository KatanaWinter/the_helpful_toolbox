import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/data/models/client.dart';
import 'package:the_helpful_toolbox/features/clients/dialog/editBillingAddressDialog.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class BillingAddressCard extends StatefulWidget {
  Client client;
  BillingAddressCard(this.client, {super.key});

  @override
  State<BillingAddressCard> createState() => _BillingAddressCardState();
}

class _BillingAddressCardState extends State<BillingAddressCard> {
  @override
  Widget build(BuildContext context) {
    double contentWidth = getContentWidth(context);
    return SizedBox(
      child: Card(
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
                      AutoSizeText(
                        'Billing Address',
                        style: TextStyle(fontSize: 20),
                        maxLines: 3,
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
                      Column(
                        children: [
                          AutoSizeText(
                            widget.client.billingAddress?.street ?? "",
                            maxLines: 3,
                          ),
                          AutoSizeText(
                            "${widget.client.billingAddress?.city ?? ""} , ${widget.client.billingAddress?.state ?? ""} ${widget.client.billingAddress?.postalcode ?? ""}",
                            maxLines: 3,
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            openEditPropertyDialog(context, widget.client);
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  openEditPropertyDialog(context, Client client) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditBillingAddressDialog(client: client);
      },
    );
  }
}
