class WalletTransaction {
  final String id;
  final String userId;
  final double amount; // + credit, - debit
  final String reason;
  final DateTime createdAt;

  const WalletTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.reason,
    required this.createdAt,
  });
}
