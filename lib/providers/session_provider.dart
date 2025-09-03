import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import 'services_provider.dart';

final currentUserProvider = StateProvider<AppUser?>((ref) => null);

final isAuthenticatedProvider = Provider<bool>((ref) => ref.watch(currentUserProvider) != null);

final roleProvider = Provider<UserRole?>((ref) => ref.watch(currentUserProvider)?.role);

Future<void> demoLogin(WidgetRef ref, UserRole role, String name) async {
  final auth = ref.read(authServiceProvider);
  final user = await auth.signInAs(role: role, name: name);
  ref.read(currentUserProvider.notifier).state = user;
}
