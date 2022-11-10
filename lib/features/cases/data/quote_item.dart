import 'package:the_helpful_toolbox/features/cases/data/quote.dart';

class Quote_Item {
  int? id;
  Quote quote;
  String name;
  String description;
  double quantity;
  double unit_price;
  double total;
  double discount;
  bool optional;
  DateTime? createdAt;

  Quote_Item({
    required this.quote,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unit_price,
    required this.total,
    required this.discount,
    this.optional = false,
  });
}
