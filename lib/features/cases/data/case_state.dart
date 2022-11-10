class CaseState {
  int? id;
  String name;

  CaseState({
    required this.name,
  });
}

getAllStateFilter() {
  return [
    CaseState(name: "All"),
    CaseState(name: "Request"),
    CaseState(name: "Quote"),
    CaseState(name: "Job"),
    CaseState(name: "Invoice"),
  ];
}
