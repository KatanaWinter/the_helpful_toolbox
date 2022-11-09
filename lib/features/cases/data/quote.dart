import 'package:the_helpful_toolbox/features/cases/data/case.dart';

class Quote {
  int? id;
  int opportunity;
  String message;
  double subtotal;
  double discount;
  double tax;
  double total;
  bool requiredDeposit;
  double? deposit;
  DateTime? createdAt;

  Quote({
    this.opportunity = 5,
    required this.message,
    this.subtotal = 0.00,
    this.discount = 0.00,
    this.tax = 0.00,
    this.total = 0.00,
    this.requiredDeposit = false,
  });
}
