class NoticeModel {
  final String title;
  final DateTime date;
  final bool isNew;
  final String body;
  bool isExpanded;

  NoticeModel({
    required this.title,
    required this.date,
    required this.isNew,
    required this.body,
    this.isExpanded = false,
  });
}
