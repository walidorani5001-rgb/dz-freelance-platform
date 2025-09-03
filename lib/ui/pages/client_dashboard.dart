import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/services_provider.dart';
import '../../providers/session_provider.dart';
import '../../ui/widgets/project_card.dart';

class ClientDashboard extends ConsumerWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final projects = ref.watch(projectServiceProvider).projects;
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الزبون'),
        actions: [
          IconButton(onPressed: () => context.go('/chats'), icon: const Icon(Icons.chat_bubble_outline)),
          IconButton(onPressed: () => context.go('/settings'), icon: const Icon(Icons.settings)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/post'),
        label: const Text('أنشر مشروع'),
        icon: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('مرحبًا، ${user?.name ?? 'ضيف'}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (c, i) => ProjectCard(
                  project: projects[i],
                  onTap: () => context.go('/project/${projects[i].id}'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
