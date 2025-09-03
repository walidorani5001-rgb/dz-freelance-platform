import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/services_provider.dart';
import '../../providers/session_provider.dart';
import '../../ui/widgets/message_bubble.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  final String roomId;
  const ChatRoomPage({super.key, required this.roomId});

  @override
  ConsumerState<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chat = ref.watch(chatServiceProvider);
    final me = ref.watch(currentUserProvider);
    final messages = chat.messages(widget.roomId);
    return Scaffold(
      appBar: AppBar(title: Text('غرفة: ${widget.roomId}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (c, i) {
                final m = messages[i];
                final isMine = m.senderId == me?.id;
                return MessageBubble(message: m, isMine: isMine);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _ctrl, decoration: const InputDecoration(hintText: 'اكتب رسالة...'))),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final text = _ctrl.text.trim();
                    if (text.isEmpty || me == null) return;
                    await ref.read(chatServiceProvider).sendText(widget.roomId, me.id, text);
                    setState(() {});
                    _ctrl.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
