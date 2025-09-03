import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/services_provider.dart';
import '../../providers/session_provider.dart';
import 'package:go_router/go_router.dart';

class PostProjectPage extends ConsumerStatefulWidget {
  const PostProjectPage({super.key});
  @override
  ConsumerState<PostProjectPage> createState() => _PostProjectPageState();
}

class _PostProjectPageState extends ConsumerState<PostProjectPage> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _budget = TextEditingController(text: '20000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نشر مشروع جديد')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(controller: _title, decoration: const InputDecoration(labelText: 'العنوان')),
                const SizedBox(height: 12),
                TextField(controller: _desc, decoration: const InputDecoration(labelText: 'الوصف'), maxLines: 4),
                const SizedBox(height: 12),
                TextField(controller: _budget, decoration: const InputDecoration(labelText: 'الميزانية بالدينار'), keyboardType: TextInputType.number),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () async {
                    final svc = ref.read(projectServiceProvider);
                    final user = ref.read(currentUserProvider);
                    if (user == null) return;
                    await svc.postProject(
                      title: _title.text.trim().isEmpty ? 'مشروع بدون عنوان' : _title.text.trim(),
                      description: _desc.text.trim(),
                      budget: double.tryParse(_budget.text) ?? 0,
                      clientId: user.id,
                    );
                    if (!mounted) return;
                    context.go('/client');
                  },
                  child: const Text('نشر'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
