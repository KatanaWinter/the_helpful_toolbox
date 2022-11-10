import 'package:the_helpful_toolbox/features/cases/data/case_status.dart';
import 'package:the_helpful_toolbox/features/clients/data/property.dart';

class Invoice {
  int? id;
  DateTime? issue_date;
  DateTime? payment_due;
  DateTime? created_at;
  Property billing_address;
  double total_amount;
  double balance_amount;
  CaseStatus status;

  Invoice(
      {required this.billing_address,
      this.total_amount = 0.00,
      this.balance_amount = 0.00,
      required this.status});
}
