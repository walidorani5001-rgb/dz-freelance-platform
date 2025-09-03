import 'package:uuid/uuid.dart';
import '../models/message.dart';

class ChatService {
  final _uuid = const Uuid();
  final Map<String, List<Message>> _rooms = {}; // roomId -> messages

  List<Message> messages(String roomId) => List.unmodifiable(_rooms[roomId] ?? []);

  Future<Message> sendText(String roomId, String senderId, String text) async {
    final m = Message(
      id: _uuid.v4(),
      roomId: roomId,
      senderId: senderId,
      content: text,
      type: MessageType.text,
      createdAt: DateTime.now(),
    );
    _rooms.putIfAbsent(roomId, () => []).add(m);
    return m;
  }
}
