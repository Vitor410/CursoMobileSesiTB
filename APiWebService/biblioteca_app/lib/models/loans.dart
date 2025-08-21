class LoansModel {
  final String? id;
  final String? userId;
  final String? bookId;
  final String startDate;
  final String dueDate;
  final String returned;

  LoansModel({
    this.id,
    this.userId,
    this.bookId,
    required this.startDate,
    required this.dueDate,
    required this.returned,
  });

  factory LoansModel.fromJson(Map<String, dynamic> json) {
    return LoansModel(
      id: json['id'],
      userId: json['userId'],
      bookId: json['bookId'],
      startDate: json['startDate'],
      dueDate: json['dueDate'],
      returned: json['returned'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'bookId': bookId,
      'startDate': startDate,
      'dueDate': dueDate,
      'returned': returned,
    };
  }
}
