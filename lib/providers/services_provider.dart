import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/project_service.dart';
import '../services/chat_service.dart';
import '../services/wallet_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final projectServiceProvider = Provider<ProjectService>((ref) => ProjectService());
final chatServiceProvider = Provider<ChatService>((ref) => ChatService());
final walletServiceProvider = Provider<WalletService>((ref) => WalletService());
