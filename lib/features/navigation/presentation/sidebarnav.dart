import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/navigation/data/nav.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/iconSidebar.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/textIconSidebar.dart';

class SidebarNavigation extends StatefulWidget {
  double screenWidth;
  SidebarNavigation(this.screenWidth, {super.key});

  @override
  State<SidebarNavigation> createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends State<SidebarNavigation> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth > 768) {
      return const SizedBox(width: 200, child: TextIconSidebar());
    } else {
      return const SizedBox(width: 50, child: IconSidebar());
    }
  }
}

openNewScreen(NavigationItem item, BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => item.Screen));
}
