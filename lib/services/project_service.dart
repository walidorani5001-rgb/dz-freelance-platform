import 'package:uuid/uuid.dart';
import '../models/project.dart';
import '../models/offer.dart';

class ProjectService {
  final _uuid = const Uuid();
  final List<Project> _projects = [];
  final List<Offer> _offers = [];

  List<Project> get projects => List.unmodifiable(_projects);
  List<Offer> offersFor(String projectId) => _offers.where((o) => o.projectId == projectId).toList();

  Future<Project> postProject({
    required String title,
    required String description,
    required double budget,
    required String clientId,
  }) async {
    final p = Project(
      id: _uuid.v4(),
      title: title,
      description: description,
      budget: budget,
      clientId: clientId,
      createdAt: DateTime.now(),
    );
    _projects.insert(0, p);
    return p;
  }

  Future<Offer> createOffer({
    required String projectId,
    required String freelancerId,
    required double price,
    required int days,
    required String message,
  }) async {
    final o = Offer(
      id: _uuid.v4(),
      projectId: projectId,
      freelancerId: freelancerId,
      price: price,
      days: days,
      message: message,
      createdAt: DateTime.now(),
    );
    _offers.add(o);
    return o;
  }

  Future<void> assignFreelancer({required String projectId, required String freelancerId}) async {
    final idx = _projects.indexWhere((p) => p.id == projectId);
    if (idx == -1) return;
    final p = _projects[idx];
    _projects[idx] = Project(
      id: p.id,
      title: p.title,
      description: p.description,
      budget: p.budget,
      clientId: p.clientId,
      freelancerId: freelancerId,
      createdAt: p.createdAt,
      status: ProjectStatus.inProgress,
      attachments: p.attachments,
    );
  }
}
