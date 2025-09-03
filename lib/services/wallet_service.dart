import 'package:uuid/uuid.dart';
import '../models/wallet.dart';

class WalletService {
  final _uuid = const Uuid();
  final Map<String, List<WalletTransaction>> _tx = {};
  double balanceOf(String userId) =>
      (_tx[userId] ?? []).fold(0.0, (sum, t) => sum + t.amount);

  List<WalletTransaction> history(String userId) => List.unmodifiable(_tx[userId] ?? []);

  Future<void> deposit({required String userId, required double amount, String reason = 'إيداع'}) async {
    final t = WalletTransaction(
      id: _uuid.v4(),
      userId: userId,
      amount: amount,
      reason: reason,
      createdAt: DateTime.now(),
    );
    _tx.putIfAbsent(userId, () => []).add(t);
  }

  Future<bool> escrowHold({required String fromUser, required double amount, String reason = 'حجز'}) async {
    final bal = balanceOf(fromUser);
    if (bal < amount) return false;
    await withdraw(userId: fromUser, amount: amount * 1, reason: reason);
    return true;
  }

  Future<void> release({required String toUser, required double amount, String reason = 'إفراج'}) async {
    await deposit(userId: toUser, amount: amount, reason: reason);
  }

  Future<void> withdraw({required String userId, required double amount, String reason = 'سحب'}) async {
    final t = WalletTransaction(
      id: _uuid.v4(),
      userId: userId,
      amount: -amount,
      reason: reason,
      createdAt: DateTime.now(),
    );
    _tx.putIfAbsent(userId, () => []).add(t);
  }
}
