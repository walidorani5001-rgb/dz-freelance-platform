import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/services_provider.dart';
import '../../providers/session_provider.dart';
import '../../models/project.dart';

class ProjectDetailPage extends ConsumerStatefulWidget {
  final String projectId;
  const ProjectDetailPage({super.key, required this.projectId});

  @override
  ConsumerState<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends ConsumerState<ProjectDetailPage> {
  final _price = TextEditingController(text: '15000');
  final _days = TextEditingController(text: '5');
  final _msg = TextEditingController(text: 'سأقوم بالمطلوب باحترافية عالية.');

  @override
  Widget build(BuildContext context) {
    final svc = ref.watch(projectServiceProvider);
    final p = svc.projects.firstWhere((e) => e.id == widget.projectId);
    final me = ref.watch(currentUserProvider);
    final isClient = me?.id == p.clientId;

    return Scaffold(
      appBar: AppBar(title: Text(p.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(p.description),
            const SizedBox(height: 12),
            Wrap(spacing: 8, children: [
              Chip(label: Text('${p.budget.toStringAsFixed(0)} DZD')),
              Chip(label: Text(p.status.name)),
            ]),
            const SizedBox(height: 24),
            if (!isClient) _freelancerOfferBox(context, p) else _clientOffersBox(context, p),
          ],
        ),
      ),
    );
  }

  Widget _freelancerOfferBox(BuildContext context, Project p) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('قدّم عرضك', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(controller: _price, decoration: const InputDecoration(labelText: 'السعر المقترح (DZD)'), keyboardType: TextInputType.number),
            const SizedBox(height: 8),
            TextField(controller: _days, decoration: const InputDecoration(labelText: 'المدة (أيام)'), keyboardType: TextInputType.number),
            const SizedBox(height: 8),
            TextField(controller: _msg, decoration: const InputDecoration(labelText: 'رسالة')),            
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                final me = ref.read(currentUserProvider);
                if (me == null) return;
                await ref.read(projectServiceProvider).createOffer(
                  projectId: p.id,
                  freelancerId: me.id,
                  price: double.tryParse(_price.text) ?? p.budget,
                  days: int.tryParse(_days.text) ?? 5,
                  message: _msg.text.trim(),
                );
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال العرض')));
                setState(() {});
              },
              child: const Text('إرسال العرض'),
            )
          ],
        ),
      ),
    );
  }

  Widget _clientOffersBox(BuildContext context, Project p) {
    final offers = ref.watch(projectServiceProvider).offersFor(p.id);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('العروض المقدمة', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            if (offers.isEmpty) const Text('لا توجد عروض بعد.')
            else ...offers.map((o) => ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text('${o.price.toStringAsFixed(0)} DZD / ${o.days} أيام'),
              subtitle: Text(o.message),
              trailing: FilledButton(
                onPressed: () async {
                  await ref.read(projectServiceProvider).assignFreelancer(projectId: p.id, freelancerId: o.freelancerId);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم قبول العرض والبدء بالمشروع')));
                  setState(() {});
                },
                child: const Text('قبول'),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
