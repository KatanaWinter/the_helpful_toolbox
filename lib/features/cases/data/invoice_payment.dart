import 'package:flutter/cupertino.dart';
import 'package:the_helpful_toolbox/features/cases/data/case_status.dart';
import 'package:the_helpful_toolbox/features/cases/data/invoice_payment_method.dart';

class InvoicePayment {
  int? id;
  InvoicePaymentMethod method;
  double amount;
  DateTime? transaction_date;
  String details;
  bool checked;

  InvoicePayment({
    required this.method,
    this.amount = 0.00,
    required this.details,
    this.checked = false,
  });
}
