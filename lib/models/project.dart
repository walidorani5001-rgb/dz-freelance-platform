enum ProjectStatus { open, inProgress, completed, cancelled }

class Project {
  final String id;
  final String title;
  final String description;
  final double budget;
  final String clientId;
  final String? freelancerId;
  final DateTime createdAt;
  final ProjectStatus status;
  final List<String> attachments;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.clientId,
    this.freelancerId,
    required this.createdAt,
    this.status = ProjectStatus.open,
    this.attachments = const [],
  });
}
