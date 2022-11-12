import 'package:the_helpful_toolbox/features/cases/data/quote.dart';

class QuoteItem {
  int? id;
  Quote quote;
  String name;
  String description;
  double quantity;
  double unitPrice;
  double total;
  double discount;
  bool optional;
  DateTime? createdAt;

  QuoteItem({
    required this.quote,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    required this.discount,
    this.optional = false,
  });
}
