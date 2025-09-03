import 'package:uuid/uuid.dart';
import '../models/user.dart';

class AuthService {
  AppUser? _current;

  AppUser? get current => _current;

  Future<AppUser> signInAs({required UserRole role, required String name}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _current = AppUser(
      id: const Uuid().v4(),
      name: name,
      email: '${name.toLowerCase().replaceAll(' ', '')}@example.com',
      avatarUrl: 'https://i.pravatar.cc/150?u=$name',
      role: role,
      rating: 4.7,
      skills: role == UserRole.freelancer ? ['Flutter', 'UI/UX', 'API'] : [],
      bio: role == UserRole.freelancer ? 'مطوّر تطبيقات محمول بخبرة 4 سنوات.' : 'رائد أعمال يبحث عن مستقلين محترفين.',
    );
    return _current!;
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _current = null;
  }
}
