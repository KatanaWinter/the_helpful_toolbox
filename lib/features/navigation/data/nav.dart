import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/cases/presentation/cases_page.dart';
import 'package:the_helpful_toolbox/features/clients/clients_page.dart';
import 'package:the_helpful_toolbox/features/company/company_page.dart';
import 'package:the_helpful_toolbox/features/dashboard/dashboard.dart';
import 'package:the_helpful_toolbox/features/offerlist/offerlists_page.dart';

class NavigationItem {
  int id;
  String name;
  Widget Screen;
  Icon icon;
  List<NavigationItem>? childs;

  NavigationItem(
      {required this.id,
      required this.name,
      required this.Screen,
      required this.icon,
      this.childs});
}

getMainNavigationItems() {
  List<NavigationItem> lNavItems = [
    NavigationItem(
        id: 1,
        name: "Dashboard",
        icon: const Icon(Icons.dashboard),
        Screen: const Dashboard()),
    NavigationItem(
        id: 2,
        name: "Clients",
        icon: const Icon(Icons.people),
        Screen: const ClientsPage()),
    NavigationItem(
        id: 3,
        name: "Cases",
        icon: const Icon(Icons.cases),
        Screen: const CasesPage()),
    NavigationItem(
        id: 4,
        name: "Company",
        icon: const Icon(Icons.business_outlined),
        Screen: const CompanyPage()),
    NavigationItem(
        id: 4,
        name: "Inventory",
        icon: const Icon(Icons.inventory),
        Screen: const CompanyPage()),
    NavigationItem(
        id: 4,
        name: "Offerlists",
        icon: const Icon(Icons.list),
        Screen: OfferlistPage()),
  ];
  return lNavItems;
}

openNewScreen(NavigationItem item, BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => item.Screen),
    (route) => false,
  );
}
