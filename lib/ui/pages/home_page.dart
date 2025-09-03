import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/session_provider.dart';
import '../../models/user.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('DZ Freelance')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('منصة فريلانس محلية', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                Text('ابحث عن المحترفين في الجزائر أو اعرض خدماتك وابدأ العمل بأمان عبر نظام الضمان (Escrow).',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: () => context.go('/auth'),
                      icon: const Icon(Icons.login),
                      label: const Text('تسجيل / دخول'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/client'),
                      icon: const Icon(Icons.business_center),
                      label: const Text('لوحة الزبون (تجريبة)'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/freelancer'),
                      icon: const Icon(Icons.work_outline),
                      label: const Text('لوحة المستقل (تجريبة)'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 12),
                Text('الأقسام الأكثر طلبًا', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    Chip(label: Text('تصميم UI/UX')),
                    Chip(label: Text('برمجة مواقع')),
                    Chip(label: Text('تطبيقات موبايل')),
                    Chip(label: Text('ترجمة')),
                    Chip(label: Text('تصوير'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await demoLogin(ref, UserRole.client, 'عميل تجريبي');
          if (context.mounted) context.go('/client');
        },
        label: const Text('جرب كعميل'),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }
}
