import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/session_provider.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/auth_page.dart';
import '../ui/pages/client_dashboard.dart';
import '../ui/pages/freelancer_dashboard.dart';
import '../ui/pages/chat_list_page.dart';
import '../ui/pages/chat_room_page.dart';
import '../ui/pages/post_project_page.dart';
import '../ui/pages/project_detail_page.dart';
import '../ui/pages/settings_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (c, s) => const HomePage()),
      GoRoute(path: '/auth', builder: (c, s) => const AuthPage()),
      GoRoute(path: '/client', builder: (c, s) => const ClientDashboard()),
      GoRoute(path: '/freelancer', builder: (c, s) => const FreelancerDashboard()),
      GoRoute(path: '/post', builder: (c, s) => const PostProjectPage()),
      GoRoute(path: '/project/:id', builder: (c, s) => ProjectDetailPage(projectId: s.pathParameters['id']!)),
      GoRoute(path: '/chats', builder: (c, s) => const ChatListPage()),
      GoRoute(path: '/chat/:room', builder: (c, s) => ChatRoomPage(roomId: s.pathParameters['room']!)),
      GoRoute(path: '/settings', builder: (c, s) => const SettingsPage()),
    ],
    redirect: (c, s) {
      final authed = ref.read(isAuthenticatedProvider);
      final loggingIn = s.fullPath == '/auth';
      if (!authed && !loggingIn && s.fullPath != '/') return '/auth';
      if (authed && loggingIn) return '/';
      return null;
    },
    refreshListenable: GoRouterRefreshStream(ref.watch(currentUserProvider.stream)),
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _sub = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  late final Stream<dynamic> _stream;
  late final dynamic _sub;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
