import 'package:the_helpful_toolbox/features/cases/data/job.dart';
import 'package:the_helpful_toolbox/features/cases/data/quote.dart';

class Job_Item {
  int? id;
  Job job;
  String name;
  String description;
  double quantity;
  double unit_price;
  double total;
  double discount;
  bool optional;
  DateTime? createdAt;

  Job_Item({
    required this.job,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unit_price,
    required this.total,
    required this.discount,
    this.optional = false,
  });
}
