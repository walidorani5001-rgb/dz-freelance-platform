import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/session_provider.dart';
import '../../models/user.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});
  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _name = TextEditingController();
  UserRole _role = UserRole.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول / حساب')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'الاسم الكامل'),
                ),
                const SizedBox(height: 12),
                SegmentedButton<UserRole>(
                  segments: const [
                    ButtonSegment(value: UserRole.client, label: Text('زبون'), icon: Icon(Icons.business_center)),
                    ButtonSegment(value: UserRole.freelancer, label: Text('مستقل'), icon: Icon(Icons.work)),
                  ],
                  selected: {_role},
                  onSelectionChanged: (s) => setState(() => _role = s.first),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () async {
                    final name = _name.text.trim().isEmpty ? 'مستخدم' : _name.text.trim();
                    await demoLogin(ref, _role, name);
                    if (!mounted) return;
                    context.go(_role == UserRole.client ? '/client' : '/freelancer');
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('دخول تجريبي'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
