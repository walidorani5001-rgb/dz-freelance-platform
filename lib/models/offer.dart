class Offer {
  final String id;
  final String projectId;
  final String freelancerId;
  final double price;
  final int days;
  final String message;
  final DateTime createdAt;

  const Offer({
    required this.id,
    required this.projectId,
    required this.freelancerId,
    required this.price,
    required this.days,
    required this.message,
    required this.createdAt,
  });
}
