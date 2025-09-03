enum UserRole { client, freelancer, admin }

class AppUser {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final UserRole role;
  final double rating;
  final List<String> skills;
  final String bio;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.role,
    this.rating = 0,
    this.skills = const [],
    this.bio = '',
  });
}
