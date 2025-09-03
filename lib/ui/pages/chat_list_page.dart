import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/session_provider.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('المحادثات')),
      body: ListView.separated(
        itemCount: 5,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (c, i) => ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text('غرفة ${i + 1}'),
          subtitle: Text('رسالة أخيرة...'),
          onTap: () => context.go('/chat/room_${i + 1}_${me?.id.substring(0,5) ?? 'anon'}'),
        ),
      ),
    );
  }
}
