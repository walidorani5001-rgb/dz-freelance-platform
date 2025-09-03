import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/services_provider.dart';
import '../../ui/widgets/project_card.dart';
import '../../providers/session_provider.dart';

class FreelancerDashboard extends ConsumerWidget {
  const FreelancerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(projectServiceProvider);
    final projects = service.projects;
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة المستقل'),
        actions: [
          IconButton(onPressed: () => context.go('/chats'), icon: const Icon(Icons.chat_bubble_outline)),
          IconButton(onPressed: () => context.go('/settings'), icon: const Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('مرحبًا ${user?.name ?? ''}، هذه المشاريع المفتوحة:', style: Theme.of(context).textTheme.titleLarge),
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
