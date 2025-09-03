import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/session_provider.dart';
import '../../providers/services_provider.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final wallet = ref.watch(walletServiceProvider);
    final bal = user == null ? 0.0 : wallet.balanceOf(user.id);

    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات والحساب')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user != null) ...[
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: Chip(label: Text(user.role.name)),
              ),
              const SizedBox(height: 12),
              Text('الرصيد: ${bal.toStringAsFixed(2)} DZD', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(spacing: 8, children: [
                FilledButton(
                  onPressed: () async {
                    await ref.read(walletServiceProvider).deposit(userId: user.id, amount: 30000, reason: 'إيداع محفظة');
                    (context as Element).markNeedsBuild();
                  },
                  child: const Text('إيداع 30,000'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await ref.read(walletServiceProvider).escrowHold(fromUser: user.id, amount: 10000);
                    (context as Element).markNeedsBuild();
                  },
                  child: const Text('حجز ضمان 10,000'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await ref.read(walletServiceProvider).release(toUser: user.id, amount: 5000);
                    (context as Element).markNeedsBuild();
                  },
                  child: const Text('إفراج 5,000'),
                ),
              ]),
              const SizedBox(height: 24),
              FilledButton.tonal(
                onPressed: () async {
                  await ref.read(authServiceProvider).signOut();
                  ref.read(currentUserProvider.notifier).state = null;
                  if (context.mounted) context.go('/');
                },
                child: const Text('تسجيل الخروج'),
              )
            ] else const Text('سجل دخولك للاستمرار')
          ],
        ),
      ),
    );
  }
}
