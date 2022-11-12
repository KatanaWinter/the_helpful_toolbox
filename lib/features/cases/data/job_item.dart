import 'package:the_helpful_toolbox/features/cases/data/job.dart';

class JobItem {
  int? id;
  Job job;
  String name;
  String description;
  double quantity;
  double unitPrice;
  double total;
  double discount;
  bool optional;
  DateTime? createdAt;

  JobItem({
    required this.job,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    required this.discount,
    this.optional = false,
  });
}
