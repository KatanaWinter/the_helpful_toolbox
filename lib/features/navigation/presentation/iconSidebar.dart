import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/navigation/data/nav.dart';

class IconSidebar extends StatelessWidget {
  const IconSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    List<NavigationItem> lNavItems = getMainNavigationItems();

    return Card(
      color: const Color.fromARGB(255, 0, 37, 67),
      margin: EdgeInsets.zero,
      elevation: 8,
      child: Column(
        children: [
          ListView.builder(
              itemCount: lNavItems.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: IconButton(
                    icon: lNavItems[index].icon,
                    // onTap: openNewScreen(lNavItems[index], context),
                    onPressed: () {
                      openNewScreen(lNavItems[index], context);
                    },
                  ),
                );
              }),
          const Spacer(),
          // IconButton(
          //   padding: EdgeInsets.all(0.0),
          //   icon: Icon(Icons.arrow_right),
          //   onPressed: () {},
          // )
        ],
      ),
    );
  }
}
